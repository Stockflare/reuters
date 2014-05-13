require 'spec_helper'

describe Reuters::Credentials do

  it { should respond_to(:username) }
  it { should respond_to(:username=) }
  it { should respond_to(:password) }
  it { should respond_to(:password=) }
  it { should respond_to(:app_id) }
  it { should respond_to(:app_id=) }

  it { should respond_to(:details) }
  
  it_behaves_like "a configurable class"

  describe "when credentials are set" do

    let(:test_username) { "david" }
    let(:test_password) { "1234" }
    let(:test_app_id) { "123" }

    before do
      subject.configure do |c|
        c.username = test_username
        c.password = test_password
        c.app_id = test_app_id
      end
    end

    it "should return the correct username" do
      expect(subject.username).to eq test_username
    end

    it "should return the correct password" do
      expect(subject.password).to eq test_password
    end

    it "should return the correct app_id" do
      expect(subject.app_id).to eq test_app_id
    end

    describe "when #details is called" do
      
      it "should yield a block once" do
        expect { |b| subject.details &b }.to yield_control.once
      end

      it "shoud yield the correct arguments" do
        expect { |b| subject.details &b }.to yield_with_args(test_username, test_password, test_app_id)
      end

    end

  end

  describe "return value of #to_h" do

    it "should be a hash" do
      expect(subject.to_h).to be_a(Hash)
    end

    it "should include credentials" do
      expect(subject.to_h).to include(:username, :password, :app_id)
    end

  end

end