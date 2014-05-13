module Reuters
  module Namespaces
    # The Base Namespace module is not meant to be directly
    # used as it does not provided any Namespace definitions.
    # Instead, it is included inside other Namespace modules as
    # it provides useful helpers.
    module Base

      # Class based methods that are set in every
      # module that includes this base module.
      module ClassMethods

        # Represents the fully resolved namespace endpoint
        # for the Namespace module that has included this
        # class method.
        #
        # @note The returned string is prefixed with the configured
        #   #namespaces_endpoint.
        #
        # @return [String] the fully resolved namespace endpoint.
        def endpoint
          "#{Reuters.namespaces_endpoint}/#{name}"
        end

        # Enables this namespace to be configured by passing in
        # itself as a block which enables static variables to
        # be set.
        #
        # @yield [config] The namespace to be configured.
        def configure
          yield self
        end

      end

      # @!parse extend ClassMethods
      extend ClassMethods

      # Extend the including class with the defined
      # class methods.
      def self.included(klass)
        klass.extend(ClassMethods)
      end

    end
  end
end