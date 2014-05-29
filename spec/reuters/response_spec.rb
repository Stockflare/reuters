require 'spec_helper'

describe Reuters::Response do

  let(:test_hash) {
    {
      info: {
        ticker: "ABC",
        name: {
          full_name: "ABC Solutions Ltd.",
          short_name: "ABC Ltd."
        }
      },
      :@type => "ORD"
    }
  }

  before do 
    @response = Reuters::Response.new(test_hash)
  end

  subject { @response }

  it { should respond_to(:attributes) }

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
