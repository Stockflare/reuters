module Reuters
  module Wsdls
    # Represents the WSDL used by Reuters in their internal API for
    # providing information related to the operations that can be
    # performed to retrieve access tokens.
    module Token

      include Base

      # Wsdl for the TokenManagement endpoint.
      mattr_accessor :name
      self.name = 'TokenManagement'

      # Method to use for the Wsdl
      mattr_accessor :method
      self.method = 'TokenManagement_1_HttpsAndAnonymous_Soap11.wsdl'

    end
  end
end