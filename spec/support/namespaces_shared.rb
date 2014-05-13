shared_examples "a namespace module" do

  it { should respond_to(:name) }
  it { should respond_to(:name=) }
  it { should respond_to(:endpoint) }
  it { should respond_to(:configure) }

  it_behaves_like "a configurable class"

  it "#endpoint should return a fully resolved endpoint name" do
    expect(subject.endpoint).to include(Reuters.namespaces_endpoint)
  end

end