require 'spec_helper'

describe Reuters::Namespaces do

  it { should respond_to(:configure) }

  describe "when a namespace is defined" do

    before do
      module Reuters::Namespaces
        module TestNamespace
          include Base
        end
      end
    end

    it "should enable configuration of a namespace" do
      expect { |b| subject.configure("TestNamespace", &b) }.to yield_with_args Reuters::Namespaces::TestNamespace
    end

  end

  describe "when a namespace is not defined" do

    it "should raise an error" do
      expect { |b| subject.configure("FuddyWsdl", &b) }.to raise_error
    end

  end

end