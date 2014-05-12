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
        soap.namespaces["xmlns:n0"]  = self.namespace
        soap.namespaces["xmlns:n1"]  = self.common
        soap.namespaces["xmlns:adr"] = "http://www.w3.org/2005/08/addressing"
        yield if block
      end
    end

    private

    def client
      Savon::Client.new self.wsdl
    end

    def common
      "#{Reuters.namespaces_endpoint}/#{Reuters::Namespaces::Token.management}"
    end

    end
  end
end