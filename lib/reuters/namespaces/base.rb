module Reuters
  module Namespaces
    # The Base Namespace module is not meant to be directly
    # used as it does not provided any Namespace definitions.
    # Instead, it is included inside other Namespace modules as
    # it provides useful helpers.
    module Base

      module ClassMethods

        def endpoint
          "#{Reuters.namespaces_endpoint}/#{name}"
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