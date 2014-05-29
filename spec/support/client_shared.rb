shared_examples "a client class" do

  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  it { should respond_to(:request) }
  it { should respond_to(:client) }
  it { should respond_to(:operations) }

  it { should respond_to(:before_request) }
  it { should respond_to(:after_request) }  

  describe "return value of #client.operations" do
    it "should be an Array" do
      expect(subject.client.operations).to be_a(Array)
    end

    it "should not be empty" do
      expect(subject.client.operations).to_not be_empty
    end
  end

  describe "when an operation is called" do

    describe "when the operation does not exist" do
      it "should raise a no method error" do
        expect { subject.not_a_valid_op }.to raise_error(NoMethodError)
      end
    end

    describe "when the operation exists" do

      let(:test_op) { :test }
      let(:message) { Reuters::Builder.new }

      before do
        subject.stub_chain(:client, :operations).and_return([test_op])
      end

      it "should attempt a request" do
        subject.should_receive(:request).with(test_op, message)
        subject.test(message)
      end

      describe "when additional request attributes are passed" do

        let(:attribs) { {:a => 1, :b => true} }

        it "should pass attributes to the request" do
          subject.should_receive(:request).with(test_op, message, attribs)
          subject.test(message, attribs)
        end
        
      end

    end

  end

  describe "return value of #client" do

    it "should be a Savon Client" do
      expect(subject.client).to be_a(Savon::Client)
    end

  end

end