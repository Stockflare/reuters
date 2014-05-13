require 'spec_helper'

describe Reuters::Client::Token do

  before { @token = Reuters::Client::Token.new }

  subject { @token }

  it_behaves_like "a client class"

  describe "authenticating" do

    pending

  end

end