module Reuters
  module Namespaces
    # Common namespaces are used in most API Calls and represent
    # the common set of Namespaces shared amongst most Reuters
    # API requests.
    module Common

      # @!parse include Base

      include Base

      # Year for the Common endpoint.
      mattr_accessor :year
      self.year = '2006'

      # Month for the Common endpoint.
      mattr_accessor :month
      self.month = '05'

      # Day for the Common endpoint.
      mattr_accessor :day
      self.day = '01'

      # Name for the Common endpoint.
      mattr_accessor :name
      self.name = 'Common_1'

    end
  end
end