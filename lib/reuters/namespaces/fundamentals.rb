module Reuters
  module Namespaces
    module Fundamentals

      # @!parse include Base

      include Base

      # Year for the Fundaments endpoint.
      mattr_accessor :year
      self.year = "2009"

      # Month for the Fundaments endpoint.
      mattr_accessor :month
      self.month = "01"

      # Day for the Fundaments endpoint.
      mattr_accessor :day
      self.day = "26"

      # Name for the Fundaments endpoint.
      mattr_accessor :name
      self.name = 'Fundamentals_1'

    end
  end
end