module MobileCity
  class WebApp < Sinatra::Base
    include Alf::Rack::Helpers
    include Alf::Lang::Predicates

    configure do
      set :wlang, { layout: :"html5" }
      enable  :raise_errors
      enable  :dump_errors
      disable :show_exceptions
    end

    use Alf::Rack::Connect do |cfg|
      cfg.database = SQLITE_DB
    end
    use Rack::UiState
    use Rack::AcceptOverride
    use Rack::Accept

  protected

    MEDIA_TYPES = [
      'application/json',
      'text/html',
      'text/plain',
    ]

    def base_db
      db = Viewpoint::Base.new(alf_connection)
    end

    def users
      base_db
        .user_profiles
    end

    def languages
      base_db
        .poi_descriptions
        .project([:lang])
    end

    def places
      base_db
        .pois
        .restrict(eq(:parent, :poi))
        .project([:poi])
    end

    def state
      env['ui-state']
    end

    def render_value(value)
      accept = env['rack-accept.request']
      best = accept.best_media_type(MEDIA_TYPES)
      case best
      when 'application/json'
        content_type :json
        value.to_json
      when 'text/html'
        content_type :html
        value.to_html
      when 'text/plain'
        content_type "text/plain"
        pois.to_text
      else
        router.status 406
      end
    end

  end # class WebApp
end # module MobileCity
