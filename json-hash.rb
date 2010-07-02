class Hash
  def dottable!
    class << self
      def method_missing(sym, *args, &block)
        result = fetch(sym.to_s) { fetch(sym) }
        if result.respond_to?(:dottable!) then result.dottable! else result end
      rescue IndexError
        super
      end

      alias_method :regular_reader, :[] unless method_defined?(:regular_reader)

      def [](key)
        result = regular_reader(key)
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

hsh = {:a => {'b' => [1, {:c => :d}]}}.dottable!

hsh.a.b

hsh[:a]['b']

hsh.a.b[1].c

json_object = {"a" => {"b" => {"c" => ["foo", {"d" => "bar"}]}}}.dottable!

json_object.a['b'].c[1].d
