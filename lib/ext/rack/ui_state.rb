module Rack
  class UiState

    class QueryVar

      def initialize(name, defined, value)
        @name = name
        @defined = defined
        @value = value
      end
      attr_reader :name, :value

      def defined?
        @defined
      end

      def not_defined?
        !self.defined?
      end

      def respond_to?(name)
        true
      end
      alias :has_key? :respond_to?

      def method_missing(name, *args, &bl)
        return super if bl || !args.empty?
        case value
        when Array then value.include?(name.to_s)
        else
          value.to_s == name.to_s
        end
      end
      alias :[] :method_missing

      def to_s
        value.to_s
      end
      alias :to_html :to_s
    end # class QueryVar

    class State

      def initialize(params)
        @params = params
      end
      attr_reader :params

      def respond_to?(name)
        true
      end
      alias :has_key? :respond_to?

      def method_missing(name, *args, &bl)
        if name.to_s =~ /=$/ && args.length == 1 && bl.nil?
          params[name.to_s[0...-1]] = args.first
        else
          return super if bl || !args.empty?
          value = params[name.to_s]
          defin = !value.nil? && !value.empty?
          QueryVar.new(name, defin, value)
        end
      end
      alias :[] :method_missing

    end # class State

    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      env['ui-state'] = State.new(request.params)
      @app.call(env)
    end

  end # class UiState
end # module Rack
