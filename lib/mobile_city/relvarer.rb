module MobileCity
  class Relvarer

    def initialize(connection, viewpoint)
      @connection = connection
      @viewpoint = viewpoint
    end

    def has_key?(name)
      @viewpoint.members.include?(name)
    end

    def [](name)
      @connection.relvar(name)
    end

    def method_missing(name, *args, &bl)
      return super if !args.empty? or bl or !has_key?(name)
      self.[](name)
    end

    def close
      @connection.close
    end

  end # class Relvarer
end # module MobileCity
