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
      # @return [Object] The Savon Response object.
      def request(type, opts = {})
        response.new client.call(type, opts.deep_merge(
          soap_header: { 
            'ApplicationID' => @token.app_id,
            'Token' => @token.token
          }
          attributes: { 'xmlns' => namespace.endpoint })).body
      end

      # Retrieves the {Namespaces} module that is associated
      # with this client. The name of client represents the
      # name of the namespaced module. Ie. {Client::Token} would
      # have a corresponding {Namespaces::Token} module.
      #
      # @return [Module] the namespace representing this client.
      def namespace
        Reuters::Namespaces.const_get client_name
      end

      # Retrieves the {Wsdls} module that is associated
      # with this client. The name of client represents the
      # name of the WSDL module. Ie. {Client::Token} would
      # have a corresponding {Wsdls::Token} module.
      #
      # @return [Module] the namespace representing this client.
      def wsdl
        Reuters::Wsdls.const_get client_name
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

      private

      def client_name
        self.class.name.demodulize
      end

      def common
        Reuters::Namespaces::Common
      end

      def options
        {
          wsdl: wsdl.endpoint,
          ssl_version: :SSLv3,
          namespace_identifier: nil,
          ssl_verify_mode: :none
        }
      end

    end
  end
end