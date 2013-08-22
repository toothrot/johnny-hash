This is a terrible idea
-----------------------

Jsony-Hash
==========

Examples
--------

    hsh = {:a => {'b' => [1, {:c => :d}]}}.json!

    hsh.a.b # => [1, {:c=>:d}]

    hsh[:a]['b'] # => [1, {:c=>:d}]

    hsh.a.b[1].c # => :d

    json_object = {"a" => {"b" => {"c" => ["foo", {"d" => "bar"}]}}}.json!

    json_object.a['b'].c[1].d # => bar
