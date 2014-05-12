module Reuters
  module Namespaces
    # Represents namespaces used by Reuters in their internal API for
    # managing Access Tokens that are granted when valid credentials
    # are used to authenticate.
    module Token

      # Namespace for the TokenManagement endpoint.
      mattr_accessor :management
      @@management = 'webservices/rkd/TokenManagement_1'


    end
  end
end