require 'spec_helper'

describe Reuters::Client::Token do

  before { @token = Reuters::Client::Token.new }

  subject { @token }

  it_behaves_like "a client class"

  it { should respond_to(:token) }
  it { should respond_to(:expires_at) }

  it { should respond_to(:username) }
  it { should respond_to(:password) }
  it { should respond_to(:app_id) }

  it { should respond_to(:authenticate) }

  describe "when the user attempts to #authenticate" do

    describe "when the credentials are valid" do

      include Savon::SpecHelper

      before(:all) { savon.mock! }
      after(:all) { savon.unmock! }

      let(:test_response) { File.read("spec/fixtures/responses/token.xml") }

      before { savon.expects(:create_service_token_1).with(message: :any).returns(test_response) }

      it "should return a token response object" do
        expect(@token.authenticate).to be_a(Reuters::Response::Token)
      end

      it "authenticates the user with Reuters API" do
        expect { @token.authenticate }.to_not raise_error
      end

      it "populates the response object" do
        expect(@token.authenticate.token).to_not be_nil
      end

    end

    describe "when the credentials are not valid" do
      it "raises a Savon SOAP Client Error" do
        expect { @token.authenticate }.to raise_error
      end
    end

  end

end