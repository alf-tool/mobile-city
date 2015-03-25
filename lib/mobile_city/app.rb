module MobileCity
  class App < WebApp

    configure do
      set :root, Path.dir/'app'
    end

    get '/' do
      wlang :login, locals: {
        users:  users.to_a,
        places: places.to_a,
        languages: languages.to_a
      }
    end

    get '/pois' do
      redirect '/' unless valid_context?
      serve :pois, db.pois.to_a
    end

    get '/pois/:poi' do |poi|
      redirect '/' unless valid_context?
      serve :poi, db.pois
        .restrict(eq(poi: poi) | eq(parent: poi))
        .extend(:parent => poi)
        .image(db.poi_images, :images)
        .hierarchize([:poi], [:parent], :children)
        .tuple_extract
    end

  private

    MEDIA_TYPES = [
      'application/json',
      'text/html',
    ]

    def serve(who, what)
      accept = env['rack-accept.request']
      best = accept.best_media_type(MEDIA_TYPES)
      case best
      when 'application/json'
        content_type :json
        what.to_json
      when 'text/html'
        content_type :html
        wlang who, locals: base_locals.merge(who => what)
      else
        router.status 406
      end
    end

    def base_locals
      { state: state,
        context: "lang=#{state.lang}&user=#{state.user}&place=#{state.place}" }
    end

    def db
      db = Viewpoint::Base.new(alf_connection)
      db = Viewpoint::Localized.new(db, lang: state.lang.to_s)
      db = Viewpoint::Geolized.new(db, place: state.place.to_s)
      db = Viewpoint::Privacy.new(db, user: state.user.to_s)
      db = Viewpoint::Ethics.new(db, user: state.user.to_s)
      db = Viewpoint::Flatten.new(db)
      db
    end

    def valid_context?
      state.user.defined? and state.lang.defined? and state.place.defined?    
    end

  end
end
