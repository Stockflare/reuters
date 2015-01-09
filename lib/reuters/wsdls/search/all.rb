module Reuters
  module Wsdls
    module Search
      # The Search All WSDL endpoint is used by the
      # {Reuters::Client::Search::All} class to discover
      # and make search-all-based API calls.
      module All

        # @!parse include Base

        include Base

        # Wsdl for the TokenManagement endpoint.
        mattr_accessor :name
        self.name = 'Search'

        # Default method for this Wsdl
        mattr_accessor :method
        self.name = 'Searchall_1_HttpAndRkdToken_Soap11.wsdl'

      end

    end
  end
end
