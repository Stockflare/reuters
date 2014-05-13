module Reuters
  module Client
    # The base class for the client is not meant to be directly
    # initialized but instead contains common functionality
    # shared by most classes inside the Client.
    #
    # This class also handles authenticating the user with the
    # Reuter's API and handling the resulting token provided.
    class Base

      delegate :action, to: :namespace

      delegate :operations, to: :client

      def client
        Savon.client(
          wsdl: wsdl.endpoint,
          soap_version: 2,
          log: false,
          namespaces: {
            'xmlns:n0' => namespace.endpoint,
            'xmlns:n1' => common.endpoint,
            'xmlns:adr' => 'http://www.w3.org/2005/08/addressing'
          }
        )
      end

      def request(type, action, opts = {}, &block)
        client.request type, action, opts do
          yield if block
        end
      end

      def namespace
        Reuters::Namespaces.const_get client_name
      end

      private

      def client_name
        self.class.name.demodulize
      end

      def common
        Reuters::Namespaces::Common
      end

      def wsdl
        Reuters::Wsdls.const_get client_name
      end

    end
  end
end