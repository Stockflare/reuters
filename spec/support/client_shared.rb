shared_examples "a client class" do

  it { should respond_to(:request) }
  it { should respond_to(:client) }
  it { should respond_to(:namespace) }
  it { should respond_to(:action) }
  it { should respond_to(:operations) }

  describe "return value of #namespace" do

    it "should be a fully resolved namespace" do
      expect(subject.namespace.endpoint).to include(Reuters.namespaces_endpoint)
    end

    describe "when no namespace is set" do
      before { subject.stub(:namespace) { nil } }
      it "should raise an error" do
        expect { subject.namespace.endpoint }.to raise_error
      end
    end

  end

  describe "return value of #client" do

    include Savon::SpecHelper

    before(:all) { savon.mock! }
    after(:all) { savon.unmock! }

    it "should be a Savon Client" do
      expect(subject.client).to be_a(Savon::Client)
    end

  end

end