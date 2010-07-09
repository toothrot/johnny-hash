module JohnnyHash
  def self.walk_the_line!(value, raise_on_missing)
    if value.respond_to?(:json!) then value.json!(raise_on_missing) else value end
  end

  module Hash
    def json!(raise_on_missing = true)
      @raise_on_missing = raise_on_missing

      unless respond_to?(:non_json_reader)
        class << self
          alias_method :non_json_reader, :[]

          def [](key)
            JohnnyHash.walk_the_line!(non_json_reader(key), @raise_on_missing)
          end

          def method_missing(sym, *args, &block)
            self[sym] || self[sym.to_s] || (super if @raise_on_missing)
          end
        end
      end

      self
    end
  end

  module Array
    def json!(raise_on_missing = true)
      each {|element| JohnnyHash.walk_the_line!(element, raise_on_missing) }
    end
  end
end

Hash.send(:include, JohnnyHash::Hash)
Array.send(:include, JohnnyHash::Array)
