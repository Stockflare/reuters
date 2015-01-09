require 'spec_helper'

describe Reuters::Builder do

  before { @builder = Reuters::Builder.new }

  subject { @builder }

  it { should respond_to(:attributes) }

  it "should correctly camelcase a body key" do
    @builder.test_method
    expect(@builder.keys).to include("TestMethod")
  end

  it "should call a block" do
    expect { |b| Reuters::Builder.new &b }.to yield_control.once
  end

  it "should pass itself to the block" do
    expect { |b| Reuters::Builder.new &b }.to yield_with_args(Reuters::Builder)
  end

  it "should chain body calls inside the block" do
    b = Reuters::Builder.new { |b| b.test_method }
    expect(b).to include("TestMethod")
  end

  describe "return value of #attribute_key?" do

    before do
      @builder.hold_key
      @builder.business_entity(include: true).string_value(value: "QUOTE.FUND", negated: false)
      @builder.attributes({ business_entity: { 'xmlns' => "http://test" } }, false)
      # @builder.attributes(hold_key: { "test_build" => "Type" })
    end

    it "should allow camelcase keys" do
      expect(@builder.attribute_key?(:business_entity, "Include")).to be_true
    end

    it "should allow underscore keys" do
      expect(@builder.attribute_key?(:business_entity, 'xmlns')).to be_true
    end

  end

  describe "return value of #attribute_keys" do

    before do
      @builder.hold_key
      @builder.attributes(hold_key: { "test_build" => "Type" })
      @builder.attributes({ hold_key: { "xml_ns" => "Type" } }, false)
    end

    subject { @builder.attribute_keys(:hold_key) }

    it { should include "TestBuild", "xml_ns" }

    it { should_not include :attributes! }

    it { should_not be_empty }

    specify { expect { @builder.attributes(hold_key: { "t" => "a" }) }.to change { @builder.attribute_keys(:hold_key) } }

  end

  describe "return value of #keys" do

    before do
      @builder.foo_test
      @builder.bar_test
    end

    it "should include camelcased keys" do
      expect(@builder.keys).to include("FooTest", "BarTest")
    end

    it "should not include underscored keys" do
      expect(@builder.keys).to_not include(:foo_test, :bar_test, 'foo_test', 'bar_test')
    end

    it "should not be empty" do
      expect(@builder.keys).to_not be_empty
    end

    it "should add new keys" do
      expect { @builder.david }.to change { @builder.keys }
    end

    it "should not include attributes!" do
      expect(@builder.keys).to_not include(:attributes!)
    end
  end

  describe "return value of #key?" do

    before { @builder.test_build }

    it "should allow camelcase keys" do
      expect(@builder.key?("TestBuild")).to be_true
    end

    it "should allow underscore keys" do
      expect(@builder.key?(:test_build)).to be_true
    end

  end

  describe "when a block is passed to a nested builder" do

    it "should call the block" do
      expect { |b| @builder.foo.bar &b }.to yield_control.once
    end

    it "should enable modifications inside the block" do
      @builder.foo.bar { |body| body.test = 1 }
      expect(@builder.foo.bar.key?(:test)).to_not be_false
    end

  end

  describe "when attributes are set" do

    let(:attributes) { { "xmlns" => "http://..." } }

    it "should set attributes" do
      @builder.test(attributes)
      expect(@builder[:attributes!]["Test"]).to include "Xmlns"
    end

    describe "when camelcasing is disabled" do

      it "should still camcelcase the key" do
        @builder.test(attributes, false)
        expect(@builder[:attributes!]).to include "Test"
      end

      it "should set attributes that aren't camelcased" do
        @builder.test(attributes, false)
        expect(@builder[:attributes!]["Test"]).to include "xmlns"
      end

    end

  end

  describe "when a chain of keys is set" do

    it "should set all keys" do
      expect(@builder.this.is.a.chain).to_not be_nil
    end

    it "should set attributes for a nested key" do
      @builder.this(a: 1).is.a(b: 2).chain
      expect(@builder[:attributes!]).to include({"This" => { "A" => 1}})
    end

    it "should set nested attributes for a nested key" do
      @builder.this(a: 1).is.a(b: 2).chain
      expect(@builder.this.is[:attributes!]).to include({"A" => { "B" => 2}})
    end

  end

  describe "when the value is explicitly set" do

    it "should set a string" do
      @builder.test = "foobar"
      expect(@builder).to include({"Test" => "foobar"})
    end

    it "should set an array" do
      @builder.test = [1,2,3,4]
      expect(@builder).to include({"Test" => [1,2,3,4]})
    end

    it "should set an integer" do
      @builder.test = 1
      expect(@builder).to include({"Test" => 1})
    end

  end

  it "should set attributes for a key" do
    @builder.test a: true
    expect(@builder[:attributes!]).to include("Test")
  end

  it "should camelize attribute keys" do
    @builder.test a: 1
    expect(@builder[:attributes!]["Test"]).to include "A"
  end

  it "should set multiple attributes for a key" do
    @builder.test a: 1, b: 2, c: 3
    expected_attributes = { "A" => 1, "B" => 2, "C" => 3 }
    expect(@builder[:attributes!]["Test"]).to include expected_attributes
  end

  describe "when the key is an array" do

    let(:test_array) { [{a: 1, b: 2}, {a: 3, b: 4}] }

    before { @builder.test test_array }

    it "should set an array for the key" do
      expect(@builder["Test"]).to be_a(Array)
    end

    it "should set an array of the correct length" do
      expect(@builder["Test"].count).to eq test_array.count
    end

    it "should set an attribute for the key" do
      expect(@builder[:attributes!]["Test"]).to be_a(Hash)
    end

    it "should include the attribute keys" do
      expect(@builder[:attributes!]["Test"].keys).to include("A", "B")
    end

    it "should order the attributes correctly" do
      expect(@builder[:attributes!]["Test"]["A"]).to eq ["1","3"]
    end

  end

end
