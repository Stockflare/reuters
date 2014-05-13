require 'spec_helper'

describe Reuters do

  it "should have a valid version number" do
    expect(Gem::Version.correct?(Reuters::VERSION)).to eq(0)
  end

end