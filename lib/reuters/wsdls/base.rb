module Reuters
  module Wsdls
    # The Base WSDL module is not meant to be directly
    # used as it does not provided any WSDL definitions.
    # Instead, it is included inside other WSDL modules as
    # it provides useful helpers.
    module Base

      module ClassMethods

        def endpoint
          "#{Reuters.wsdl_endpoint}/#{name}/wsdl/#{method}"
        end

        def configure
          yield self
        end

      end

      extend ClassMethods

      def self.included(klass)
        klass.extend(ClassMethods)
      end

    end
  end
end