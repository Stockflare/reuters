require 'reuters/namespaces/base'
require 'reuters/namespaces/token'
require 'reuters/namespaces/common'
require 'reuters/namespaces/fundamentals'
require 'reuters/namespaces/search'

module Reuters
  # The {Namespaces} module contains sets of endpoints that
  # are used by Reuters in their internal API. Different
  # Namespaces are used by various clients to gain access
  # to data via API Calls to these namespaced endpoints.
  module Namespaces

    # Configure a Namespaces stored configurations.
    #
    # @note The passed in namespace is converted to a string
    #   and capitalized. It should be in the correct form.
    #
    # @param [Symbol] namespace to configure endpoints for.
    def self.configure(namespace, &block)
      const_get(namespace.to_s).configure(&block)
    end

  end
end