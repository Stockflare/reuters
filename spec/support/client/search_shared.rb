shared_examples "a search client class" do

  it_behaves_like "a client class"

  describe "return value of #response" do

    it "should be a search response class" do
      expect(subject.response.name).to include("Search")
    end

  end

end