require 'spec_helper'

describe Reuters do

  it { should respond_to(:namespaces_endpoint) }
  it { should respond_to(:wsdl_endpoint) }

  it_behaves_like "a configurable class"

end