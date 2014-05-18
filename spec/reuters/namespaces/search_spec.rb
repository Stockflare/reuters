require 'spec_helper'

describe Reuters::Namespaces::Search do

  it { should respond_to(:define) }

  it_behaves_like "a namespace module"

  describe "return value of #define" do

    it "should resolve the full endpoint" do
      expect(subject.define(:test)).to include Reuters.namespaces_endpoint
    end

    it "should camelize strings" do
      expect(subject.define(:test_spec)).to include "TestSpec"
    end

    it "should camelize multiple strings" do
      response = subject.define(:test, :hello)
      expect(response).to include("Test", "Hello")
    end

    it "should separate multiple strings with underscores" do
      response = subject.define(:test, :hello)
      expect(response).to include("Test_Hello")
    end

  end

end