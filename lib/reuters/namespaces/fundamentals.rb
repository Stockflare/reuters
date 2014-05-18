module Reuters
  module Namespaces
    # The Fundamentals namespace can be used for ascertain
    # important information about companies appearing on the
    # Reuters API. This Namespace is used by all the accompanying
    # Fundamental Client API calls.
    module Fundamentals

      # @!parse include Base

      include Base

      # Year for the Fundamentals endpoint.
      mattr_accessor :year
      self.year = '2009'

      # Month for the Fundamentals endpoint.
      mattr_accessor :month
      self.month = '01'

      # Day for the Fundamentals endpoint.
      mattr_accessor :day
      self.day = '26'

      # Name for the Fundamentals endpoint.
      mattr_accessor :name
      self.name = 'Fundamentals_1'

    end
  end
end