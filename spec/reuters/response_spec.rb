require 'spec_helper'

describe Reuters::Response do

  let(:test_hash) {
    {
      "character" => "hodor",
      info: {
        ticker: "ABC",
        number: 1,
        boolean: false,
        name: {
          full_name: "ABC Solutions Ltd.",
          short_name: "ABC Ltd."
        },
        list: [
          { fruit: "apple" },
          { fruit: "banana" }
        ],

      },
      :@type => "ORD"
    }
  }

  before do
    @response = Reuters::Response.new(test_hash)
  end

  subject { @response }

  it { should respond_to(:attributes) }

  describe "when a key is mixed type" do

    it "should return the correct value regardless" do
      expect(@response.character).to eq "hodor"
    end

  end

  describe "when a value is mixed type" do

    it "should return a number" do
      expect(@response.info.number).to eq 1
    end

    it "should a boolean" do
      expect(@response.info.boolean).to eq false
    end

  end

  describe "when a value is an array" do

    it "should return an array" do
      expect(@response.info.list).to be_a Array
    end

    it "should contain an array of Response objects" do
      expect(@response.info.list.first).to be_an_instance_of Reuters::Response
    end

    it "should access nested array response objects" do
      expect(@response.info.list.first.fruit).to eq "apple"
    end

  end

  describe "a nested response object" do

    it "should return a nested response object" do
      expect(@response.info).to be_an_instance_of Reuters::Response
    end

    it "should include a nested key" do
      expect(@response.info.keys).to include :ticker
    end

    it "should return the correct value for #full_name" do
      expect(@response.info.name.full_name).to eq "ABC Solutions Ltd."
    end

  end

  describe "when attributes are accessed" do

    it "should return a hash" do
      expect(@response.attributes).to be_a Hash
    end

    it "should return the attribute value" do
      expect(@response.attributes.type).to eq "ORD"
    end

  end

end
