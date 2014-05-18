module Reuters
  module Wsdls
    module Search
      # The Equity Search WSDL endpoint is used by the
      # {Reuters::Client::Search::Equity} class to discover
      # and make search-based API calls.
      module Equity

        # @!parse include Base

        include Base

        # Wsdl for the TokenManagement endpoint.
        mattr_accessor :name
        self.name = 'Search'

        # Default method for this Wsdl
        mattr_accessor :method
        self.name = 'EquityQuote_1_HttpAndRkdToken_Soap11.wsdl'

      end

    end
  end
end