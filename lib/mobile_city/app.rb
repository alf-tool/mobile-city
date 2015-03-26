module MobileCity
  class App < WebApp

    configure do
      set :root, Path.dir/'app'
    end

    use Rack::Robustness do |g|
      g.on(Alf::NoSuchTupleError){|ex| 404 }
      g.content_type 'text/plain'
      g.body{|ex| "404 Not Found" }
    end

    get '/' do
      wlang :login, locals: base_locals.merge({
        users:  users.to_a,
        places: places.to_a,
        languages: languages.to_a
      })
    end

    get '/pois' do
      redirect '/' unless valid_context?

      serve :pois, db({})
        .pois
        .allbut([:images])
        .to_a
    end

    get '/pois/:poi' do |poi|
      redirect '/' unless valid_context?

      serve :poi, db({place: poi})
        .pois
        .restrict(poi: poi)
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

    def db(context = {})
      context[:lang] ||= state.lang.to_s
      context[:place] ||= state.place.to_s
      context[:user] ||= state.user.to_s

      db = Viewpoint::Base.new(alf_connection)
      db = Viewpoint::Localized.new(db, context)
      db = Viewpoint::Geolized.new(db, context)
      db = Viewpoint::Privacy.new(db, context)
      db = Viewpoint::Ethics.new(db, context)
      db = Viewpoint::Flatten.new(db)
      db = Viewpoint::Structure.new(db)
      db
    end

    def valid_context?
      state.user.defined? and state.lang.defined? and state.place.defined?    
    end

  end
end
