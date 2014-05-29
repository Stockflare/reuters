module Reuters
  module Client
    module Search
      # The base class for the search client is not meant to be
      # directly initialized but instead contains common functionality
      # shared by all Search Clients.
      class Base < Reuters::Client::Base

        def initialize
          # Re-define namespace and wsdl to be scoped to search
          @namespace = Reuters::Namespaces::Search.const_get client_name
          @wsdl = Reuters::Wsdls::Search.const_get client_name
          @token = Reuters::Client::Token.new
        end

        private

        def ns_definition(*args)
          Reuters::Namespaces::Search.define(*args)
        end

      end

    end
  end
end