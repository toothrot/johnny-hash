Jsony-Hash
==========

Examples
--------

    hsh = {:a => {'b' => [1, {:c => :d}]}}.jsonify!

    hsh.a.b # => [1, {:c=>:d}]

    hsh[:a]['b'] # => [1, {:c=>:d}]

    hsh.a.b[1].c # => :d

    json_object = {"a" => {"b" => {"c" => ["foo", {"d" => "bar"}]}}}.jsonify!

    json_object.a['b'].c[1].d # => bar
