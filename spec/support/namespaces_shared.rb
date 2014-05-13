shared_examples "a namespace module" do

  it { should respond_to(:name) }
  it { should respond_to(:name=) }
  it { should respond_to(:endpoint) }
  it { should respond_to(:action) }
  it { should respond_to(:actions) }
  it { should respond_to(:configure) }
  it { should respond_to(:action_endpoint) }

  it_behaves_like "a configurable class"

  it "should enable actions to be configurable" do
    expect { |b| subject.actions &b }.to yield_with_args(subject::Actions)
  end

  it "should include namespace actions" do
    expect(subject.constants).to include(:Actions)
  end

  it "#endpoint should return a fully resolved endpoint name" do
    expect(subject.endpoint).to include(Reuters.namespaces_endpoint)
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

    describe "when a value is set" do

      let(:test_val) { "foobar" }

      before { subject::Actions.test = test_val }

      it "should retrieve an action" do
        expect(subject.action(:test)).to eq test_val
      end

      it "should retrieve a fully resolved action" do
        expect(subject.action_endpoint(:test)).to include(Reuters.namespaces_endpoint) 
      end

    end

    

  end

end