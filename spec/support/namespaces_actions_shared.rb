shared_examples "a namespace with actions" do

  it "should include namespace actions" do
    expect(subject.constants).to include(:Actions)
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

    it "should include the action in the endpoint" do
      test_action = "foobar"
      subject::Actions.test = test_action
      expect(subject.endpoint(:test)).to include(test_action)
    end

  end

end