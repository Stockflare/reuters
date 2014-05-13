require 'reuters/wsdls/base'
require 'reuters/wsdls/token'

module Reuters
  # The {Wsdls} module contains sets of endpoints that
  # are used by Reuters in their internal API. Wsdls describe
  # valid operations that can be carried out through API 
  # requests. Each API group should have an accompanying
  # WSDL, as they are used to make {Client} requests.
  module Wsdls

    # Configure a Wsdls stored configurations.
    #
    # @note The passed in wsdl is converted to a string
    #   and capitalized. It should be in the correct form.
    #
    # @param [Symbol] wsdl to configure endpoints for.
    def self.configure(wsdl, &block)
      const_get(wsdl.to_s).configure &block
    end

  end
end