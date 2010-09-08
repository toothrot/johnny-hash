require 'teststrap'

context "JohnnyHash" do
  asserts "Allows dot access for existing elements" do
    {:a => 'foo'}.json!.a
  end.equals 'foo'

  asserts "Raises a NoMethodError for non-existing elements" do
    {:a => 'foo'}.json!.b
  end.raises NoMethodError

  asserts "Optionally returns nil instead of raising on missing elements" do
    {:a => 'foo'}.json!(false).b
  end.equals nil

  context "an interesting hash" do
    setup do
      {:a => {'b' => [1, {:c => :d}]}}.json!
    end

    asserts "nests jsony-ness" do
      topic.a.b
    end.equals [1, {:c => :d}]

    asserts "nests jsony-ness on normal lookups too" do
      topic[:a].b
    end.equals [1, {:c => :d}]

    asserts "nests jsony-ness through array-style lookup" do
      topic.a.b[1].c
    end.equals :d

    asserts "nests not raising on missing through array-style lookup" do
      topic.json!(false).a.b[1].z
    end.equals nil

    asserts "json! can be called multiple times" do
      topic.json!.json!.a.b
    end.equals [1, {:c => :d}]
  end

end
