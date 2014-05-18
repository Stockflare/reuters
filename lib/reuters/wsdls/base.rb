module Reuters
  module Wsdls
    # The Base WSDL module is not meant to be directly
    # used as it does not provided any WSDL definitions.
    # Instead, it is included inside other WSDL modules as
    # it provides useful helpers.
    module Base

      # Class based methods that are set in every
      # module that includes this base module.
      module ClassMethods

        # Returns the fully resolved WSDL endpoint for the
        # including Module.
        #
        # @return [String] the fully resolved wsdl endpoint
        #   (including http://...)
        def endpoint
          "#{Reuters.wsdl_endpoint}/#{name}/wsdl/#{method}"
        end

        # Enables this WSDL to be configured by passing in
        # itself as a block which enables static variables to
        # be set.
        #
        # @yield [config] The WSDL to be configured.
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