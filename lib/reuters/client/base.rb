module Reuters
  module Client
    # The base class for the client is not meant to be directly
    # initialized but instead contains common functionality
    # shared by most classes inside the Client.
    #
    # This class also handles authenticating the user with the
    # Reuter's API and handling the resulting token provided.
    class Base

      delegate :operations, to: :client

      delegate :app_id, :token, :header, to: :@token

      # Initialize the base client class and set a token
      # that can be retrieved upon request.
      def initialize
        @wsdl = Reuters::Wsdls.const_get client_name
        @namespace = Reuters::Namespaces.const_get client_name
        @token = Reuters::Client::Token.new
      end

      # Retrieves a new instance of a Savon client that
      # has been correctly configured for sending requests
      # to the Reuter's API.
      #
      # @see http://savonrb.com/version2/client.html
      #
      # @return [Object] client to make requests through.
      def client
        Savon.client options
      end

      # Attempts to call an operation for this client through
      # the determined set of operations that have been retrieved
      # from the WSDL.
      def method_missing(op, *args)
        if client.operations.include?(op)
          request op, *args
        else
          fail NoMethodError, op
        end
      end

      # Send a correctly formatted request to the Reuter's
      # API. This method makes an authenticated request to
      # the API, assuming that a token object has been defined
      # by the extending Class.
      #
      # @note This request method calls the Savon Client #call
      #   method.
      #
      # @see http://savonrb.com/version2/requests.html
      #
      # @param [Symbol] type of request to send to Reuters API.
      # @param [Reuters::Builder] message contents to send to the API.
      # @param [Hash] attribs to attach to the request object.
      # @param [Boolean] auth defaults to true if a token is required
      #                  for this request
      #
      # @return [Object] The corresponding Response object.
      def request(type, message, attribs = {}, auth = true)

        content = {
          attributes: attribs.merge('xmlns' => @namespace.endpoint),
          message: before_request.call(message, type)
        }

        content[:soap_header] = header if auth

        data = client.call(type, content).body

        response.new after_request.call(data)

      end

      # Retrieves the response object that is associated
      # with this client. All calls to the Reuter's API
      # will initialize a new response object and populate
      # it with the data in the response.
      #
      # @return [Class] the class that will be used to parse
      #   the response from Reuter's API.
      def response
        Reuters::Response.const_get client_name
      end

      # Yields a block that is called before a request
      # is sent to Savon. The hash that is returned from
      # this block is used as the message part of the
      # Savon request.
      #
      # @note By default this request hook has no effect.
      #
      # @yield [req, type] The request object that has been
      #  sent to the client. The operation name is passed
      #  as the second parameter.
      #
      # @yieldparam req [Reuters::Builder] The request object.
      # @yieldparam type [Symbol] The intended operation to perform.
      def before_request(&block)
        @before_request = block if block
        @before_request || proc { |a| a }
      end

      # Yields a block that is called after a successful
      # request to Reuters. The object that is returned from
      # this is request is subsequently passed onto this Clients
      # corresponding response class.
      #
      # @note By default this request hook has no effect.
      #
      # @yield [req] The raw response object that
      #              has been received and parsed by Savon.
      def after_request(&block)
        @after_request = block if block
        @after_request || proc { |a| a }
      end

      private

      def client_name
        self.class.name.demodulize
      end

      def common
        Reuters::Namespaces::Common
      end

      def options
        {
          wsdl: @wsdl.endpoint,
          ssl_version: :SSLv3,
          namespace_identifier: nil,
          ssl_verify_mode: :none,
          log: Reuters.debug,
          pretty_print_xml: true
        }
      end

    end
  end
end