module Reuters
  module Wsdls
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