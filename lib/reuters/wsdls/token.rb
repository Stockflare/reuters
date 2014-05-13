module Reuters
  module Wsdls
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