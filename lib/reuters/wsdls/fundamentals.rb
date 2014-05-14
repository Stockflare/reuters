module Reuters
  module Wsdls
    module Fundamentals

      # @!parse include Base

      include Base

      # Wsdl for the TokenManagement endpoint.
      mattr_accessor :name
      self.name = 'Fundamentals'

      # Method to use for the Wsdl
      mattr_accessor :method
      self.method = 'Fundamentals_1_HttpAndRkdToken_Soap11.wsdl'

    end
  end
end