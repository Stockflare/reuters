require 'reuters/namespaces/token'
require 'reuters/namespaces/common'

module Reuters
  # The {Namespaces} module contains sets of endpoints that
  # are used by Reuters in their internal API. Different 
  # Namespaces are used by various clients to gain access
  # to data via API Calls to these namespaced endpoints.
  module Namespaces

    # Configure a Namespaces stored configurations. 
    #
    # @note The passed in namespace is converted to a string
    #   and capitalized. Ensure that the namespace is in
    #   singular form.
    #
    # @param [Symbol] namespace to configure endpoints for.
    def self.configure(namespace)
      yield self.get_const(namespace.to_s.capitalize)
    end

  end
end