module Rack
  class AcceptOverride

    EXTENSIONS = {
      'json' => 'application/json',
      'html' => 'text/html',
      'txt'  => 'text/plain'
    }

    def initialize(app)
      @app = app
    end
    attr_reader :app

    def call(env)
      request = Rack::Request.new(env)

      if env['PATH_INFO'] =~ /^(.*?)\.(json|html|txt)$/
        env['PATH_INFO']   = $1
        env['HTTP_ACCEPT'] = EXTENSIONS[$2]
      end

      @app.call(env)
    end

  end # class AcceptOverride
end # module MobileCity
