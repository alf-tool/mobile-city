module MobileCity
  class Explorer < WebApp

    configure do
      set :root, Path.dir/'explorer'
    end

    get '/' do
      wlang :db, locals: {
        db: viewpoint_db(state),
        users:  users.to_a,
        places: places.to_a,
        languages: languages.to_a,
        state: state
      }
    end

    get '/:relvar' do |relvar|
      render_value viewpoint_db(state).public_send(relvar)
    end

  private

    def viewpoint_db(state)
      db = Viewpoint::Base.new(alf_connection)
      db = Viewpoint::Localized.new(db, lang: state.lang.to_s)  if state.lang.defined?
      db = Viewpoint::Geolized.new(db, place: state.place.to_s) if state.place.defined?
      db = Viewpoint::Privacy.new(db, user: state.privacy.to_s) if state.privacy.defined?
      db = Viewpoint::Ethics.new(db, user: state.ethics.to_s)   if state.ethics.defined?
      db = Viewpoint::Flatten.new(db)                           if state.flatten.defined?
      db = Viewpoint::Structure.new(db)                         if state.structure.defined?
      db
    end

  end
end
