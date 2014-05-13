require 'spec_helper'

describe Reuters::Wsdls do

  it { should respond_to(:configure) }

  describe "when a wsdl is defined" do

    before do
      module Reuters::Wsdls
        module TestWsdl
          include Base
        end
      end
    end

    it "should enable configuration of a wsdl" do
      expect { |b| subject.configure("TestWsdl", &b) }.to yield_with_args Reuters::Wsdls::TestWsdl
    end

  end

  describe "when a wsdl is not defined" do

    it "should raise an error" do
      expect { |b| subject.configure("FuddyWsdl", &b) }.to raise_error
    end

  end

end