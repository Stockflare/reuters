require 'spec_helper'

describe Reuters::Client::Fundamentals do

  before { @fundamentals = Reuters::Client::Fundamentals.new }

  subject { @fundamentals }

  it_behaves_like "a client class"

end