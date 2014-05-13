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

      def client
        Savon.client options
      end

      def request(type, opts = {})
        client.call type, opts.deep_merge(
          attributes: { 'xmlns' => namespace.endpoint }
        )
      end

      def namespace
        Reuters::Namespaces.const_get client_name
      end

      def wsdl
        Reuters::Wsdls.const_get client_name
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