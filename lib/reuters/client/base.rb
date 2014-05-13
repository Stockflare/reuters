module Reuters
  module Client
    # The base class for the client is not meant to be directly
    # initialized but instead contains common functionality
    # shared by most classes inside the Client.
    #
    # This class also handles authenticating the user with the
    # Reuter's API and handling the resulting token provided.
    class Base

    def request(type, action, opts = {}, &block)
      client.request type, action, opts do
        yield if block
      end
    end

    delegate :namespace, to: :ns

    delegate :action, to: :ns

    delegate :operations, to: :client

    private

    def client
      Savon::Client(
        wsdl: wsdl,
        soap_version: 2,
        log: false,
        namespaces: {
          'xmlns:n0' => namespace,
          'xmlns:n1' => common,
          'xmlns:adr' => 'http://www.w3.org/2005/08/addressing'
        }
      )
    end

    def common
      "#{Reuters.namespaces_endpoint}/#{Reuters::Namespaces::Common.name}"
    end

    def self.wsdl
      nil
    end

    def ns
      Reuters::Namespaces.const_get(self.class.name)
    end

    end
  end
end