shared_examples "a client class" do

  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  it { should respond_to(:request) }
  it { should respond_to(:client) }
  it { should respond_to(:namespace) }
  it { should respond_to(:wsdl) }
  it { should respond_to(:operations) }

  # describe "when #request is called" do

  #   let(:type) { :type }
  #   let(:opts) { { message: {} } }

  #   it "should call the savon client" do
  #     savon.expects(:call).with(type, opts)
  #     subject.request(type, opts)
  #   end

  # end

  describe "return value of #namespace" do

    it "should not be empty" do
      expect(subject.namespace.endpoint).to_not be_empty
    end

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

  describe "return value of #wsdl" do

    it "should not be empty" do
      expect(subject.wsdl.endpoint).to_not be_empty
    end

    it "should be a fully resolved wsdl" do
      expect(subject.wsdl.endpoint).to include(Reuters.wsdl_endpoint)
    end

  end

  describe "return value of #client" do

    it "should be a Savon Client" do
      expect(subject.client).to be_a(Savon::Client)
    end

  end

end