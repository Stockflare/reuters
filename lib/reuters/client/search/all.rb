module Reuters
  module Client
    module Search
      # Performs a "Search All" Reuters API request. This particular
      # requests allows you to search for all types of listings, such as
      # Equities, Derivatives and Funds.
      #
      # @note All Equity Search XML Requests require that the
      #   appropriate xmlns attribute is present on elements
      #   inside the request element. This class uses the
      #   before_request hook to inject the appropriate attribute.
      class All < Equity

        # Retrieve the correctly formatted Namespace Data Type
        # for an Equity-based Search Reuters Request.
        #
        # @return [String] the fully resolved namespace endpoint.
        def data_type
          ns_definition(:query_spec_datatypes)
        end

        # Retrieve the correctly formatted Namespace Query
        # Specification for an Equity-based Search.
        #
        # @return [String] the fully resolved namespace endpoint.
        def query_spec
          ns_definition(:searchall, :query_spec, 1)
        end

      end

    end
  end
end
