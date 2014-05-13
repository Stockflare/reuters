shared_examples "a namespace module" do

  it { should respond_to(:name) }
  it { should respond_to(:name=) }
  it { should respond_to(:namespace) }
  it { should respond_to(:action) }

  it "should include namespace actions" do
    expect(subject.constants).to include(:Actions)
  end

  it "#namespace should return a fully resolved namespace name" do
    expect(subject.namespace).to include(Reuters.namespaces_endpoint)
  end

  describe "the shared Actions of a Namespace" do

    before do
      module subject::Actions
        def self.test
          @@test
        end
        def self.test=(val)
          @@test=val
        end
        @@test = nil
      end
    end

    specify { expect(subject::Actions).to respond_to(:test) }
    specify { expect(subject::Actions).to respond_to(:test=) }

    it "should modify the value" do
      expect { subject::Actions.test = 1 }.to change { subject::Actions.test }
    end

    it "should retrieve an action" do
      test_val = "foobar"
      subject::Actions.test = test_val
      expect(subject.action(:test)).to eq test_val
    end

  end

end