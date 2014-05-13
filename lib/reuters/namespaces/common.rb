module Reuters
  module Namespaces
    # Common namespaces are used in most API Calls and represent
    # the common set of Namespaces shared amongst most Reuters
    # API requests.
    module Common

      # @!parse include Base

      include Base

      mattr_accessor :name
      self.name = 'Common_1'

    end
  end
end