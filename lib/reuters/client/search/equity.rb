module Reuters
  module Client
    module Search
      # Performs a Equity Search Reuters API request. Equity
      # searches are intended to vary in complexity but allow
      # you to retrieve financial information about a
      # company on a specific exchange.
      #
      # @note All Equity Search XML Requests require that the
      #   appropriate xmlns attribute is present on elements
      #   inside the request element. This class uses the
      #   before_request hook to inject the appropriate attribute.
      class Equity < Base

        def initialize
          # process equity request objects before they are sent.
          before_request do |req|

            if req.key?(:query_header)
              req.attributes({ query_header: { 'xmlns' => data_type } }, false)
            end

            [:filter, :query].each do |section|
              if req.key?(section)

                sec = req.send(section)

                sec.keys.each do |key|
                  sec.attributes({ key => { 'xmlns' => query_spec } }, false)
                  sec[key].keys.each do |type|
                    sec[key].attributes({ type => { 'xmlns' => data_type } }, false)
                  end
                end

              end
            end

            req
          end

          super
        end

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
          ns_definition(:equity_quote, :query_spec, 1)
        end

      end

    end
  end
end
