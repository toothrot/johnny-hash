module JsonyHash
  module Hash
    def jsonify!(raise_on_missing = true)
      @raise_on_missing = raise_on_missing

      unless respond_to?(:non_dottable_reader)
        class << self
          alias_method :non_dottable_reader, :[]

          def [](key)
            jsonify_result(non_dottable_reader(key))
          end

          def method_missing(sym, *args, &block)
            self[sym] || self[sym.to_s] || (super if @raise_on_missing)
          end

        private
          def jsonify_result(result)
            if result.respond_to?(:jsonify!) then result.jsonify!(@raise_on_missing) else result end
          end
        end
      end

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
