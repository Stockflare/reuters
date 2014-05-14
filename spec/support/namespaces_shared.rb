shared_examples "a namespace module" do

  it { should respond_to(:name) }
  it { should respond_to(:name=) }
  it { should respond_to(:year) }
  it { should respond_to(:year=) }
  it { should respond_to(:month) }
  it { should respond_to(:month=) }
  it { should respond_to(:day) }
  it { should respond_to(:day=) }
  it { should respond_to(:endpoint) }
  it { should respond_to(:configure) }

  it_behaves_like "a configurable class"

  describe "return value of #endpoint" do

    before { @endpoint = subject.endpoint }

    it "should resolve the endpoint name" do
      expect(@endpoint).to include(Reuters.namespaces_endpoint)
    end

    it "should contain the year" do
      expect(@endpoint).to include(subject.year)
    end

    it "should contain the month" do
      expect(@endpoint).to include(subject.month)
    end

    it "should contain the day" do
      expect(@endpoint).to include(subject.day)
    end

    it "should contain the name" do
      expect(@endpoint).to include(subject.name)
    end

  end

end