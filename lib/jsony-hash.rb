module JsonyHash
  module Hash
    def jsonify!(raise_on_missing = true)
      class << self
        def method_missing(sym, *args, &block)
          jsonify_result(fetch(sym) { fetch(sym.to_s) })
        rescue IndexError
          super if @raise_on_missing
        end

        alias_method :non_dottable_reader, :[] unless method_defined?(:non_dottable_reader)

        def [](key)
          jsonify_result(non_dottable_reader(key))
        end

      private
        def jsonify_result(result)
          if result.respond_to?(:jsonify!) then result.jsonify!(@raise_on_missing) else result end
        end
      end

      @raise_on_missing = raise_on_missing
      self
    end
  end

  module Array
    def jsonify!(raise_on_missing = true)
      each {|element| if element.respond_to?(:jsonify!) then element.jsonify!(raise_on_missing) else element end }
    end
  end
end

Hash.send(:include, JsonyHash::Hash)
Array.send(:include, JsonyHash::Array)
