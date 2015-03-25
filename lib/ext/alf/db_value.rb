module Alf
  class DbValue
    include Alf::Lang::Functional
    include Alf::Lang::Predicates

    def initialize(up, context = {})
      @up = up
      @context = context
    end
    attr_reader :up, :context

    def members
      self.class.public_instance_methods(false)
    end

    def close
      up.close
    end

    def method_missing(name, *args, &bl)
      return super if !args.empty? or bl
      return super unless members.include?(name)
      up.public_send(name)
    end

  private

    def _op_wrap(expr)
      Relvar::Virtual.new(expr)
    end

    def _op_unwrap(expr)
      expr.expr
    end

    class Native < DbValue

      def initialize(connection, context = {})
        super(connection, context)
      end

      def method_missing(name, *args, &bl)
        return super if !args.empty? or bl
        return super unless up.adapter_connection.knows?(name)
        up.relvar(name)
      end

    end # class Native

  end # class DbValue
end # module Alf
