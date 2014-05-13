module Reuters
  module Namespaces
    # Common namespaces are used in most API Calls and represent
    # a common set of Namespaces present.
    module Common

      include Base

      mattr_accessor :name
      self.name = 'Common_1'

    end
  end
end