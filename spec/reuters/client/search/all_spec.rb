require 'spec_helper'

describe Reuters::Client::Search::All do

  before { @search = Reuters::Client::Search::All.new }

  subject { @search }

  it_behaves_like "a search client class"

  it { should respond_to(:data_type) }
  it { should respond_to(:query_spec) }

  describe "return value of #data_type" do

    it "should be a string" do
      expect(subject.data_type).to be_a(String)
    end

    it "should be a resolved namespace" do
      expect(subject.data_type).to include(Reuters.namespaces_endpoint)
    end

    it "should include the camelcased data type" do
      expect(subject.data_type).to include("QuerySpecDatatypes")
    end

  end

  describe "return value of #query_spec" do

    it "should be a string" do
      puts subject.operations.inspect
      expect(subject.query_spec).to be_a(String)
    end

    it "should be a resolved namespace" do
      expect(subject.query_spec).to include(Reuters.namespaces_endpoint)
    end

    it "should include the camelcased specification namespace" do
      expect(subject.query_spec).to include("Searchall_QuerySpec_1")
    end

  end

end
