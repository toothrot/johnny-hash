class Hash
  def dottable!
    class << self
      def method_missing(sym, *args, &block)
        convert_result(fetch(sym) { fetch(sym.to_s) })
      rescue IndexError
        super
      end

      alias_method :regular_reader, :[] unless method_defined?(:regular_reader)

      def [](key)
        convert_result(regular_reader(key))
      end

    private
      def convert_result(result)
        if result.respond_to?(:dottable!) then result.dottable! else result end
      end
    end
    self
  end
end

class Array
  def dottable!
    each {|element| if element.respond_to?(:dottable!) then element.dottable! else element end }
  end
end
