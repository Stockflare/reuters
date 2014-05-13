shared_examples "a configurable class" do

  it { should respond_to(:configure) }

  it "should be configurable" do
    expect { |b| subject.configure &b }.to yield_with_args(subject)
  end

end