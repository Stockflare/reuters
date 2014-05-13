shared_examples "a wsdl module" do

  it { should respond_to(:name) }
  it { should respond_to(:name=) }
  it { should respond_to(:method) }
  it { should respond_to(:method=) }
  it { should respond_to(:endpoint) }

  it_behaves_like "a configurable class"

  describe "the return value of #endpoint" do

    it "should return a fully resolved endpoint name" do
      expect(subject.endpoint).to include(Reuters.wsdl_endpoint)
    end

    it "should include the correct method" do
      test_method = "foO"
      subject.name = test_method
      expect(subject.endpoint).to include(test_method)
    end

    it "should include the correct name" do
      test_name = "boooo"
      subject.name = test_name
      expect(subject.endpoint).to include(test_name)
    end

  end

  describe "when values are set for the WSDL" do

    let(:test_name) { "foo" }
    let(:test_method) { "bar" }

    before do
      subject.configure do |c|
        c.name = test_name
        c.method = test_method
      end
    end

    it "should set the correct value for the name" do
      expect(subject.name).to eq test_name
    end

    it "should set the correct value for the method" do
      expect(subject.method).to eq test_method
    end

  end

end