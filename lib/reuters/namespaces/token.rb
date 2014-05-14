module Reuters
  module Namespaces
    # Represents namespaces used by Reuters in their internal API for
    # managing Access Tokens that are granted when valid credentials
    # are used to authenticate.
    module Token

      # @!parse include Base

      include Base

      # Year for the TokenManagement endpoint.
      mattr_accessor :year
      self.year = "2006"

      # Month for the TokenManagement endpoint.
      mattr_accessor :month
      self.month = "05"

      # Day for the TokenManagement endpoint.
      mattr_accessor :day
      self.day = "01"

      # Name for the TokenManagement endpoint.
      mattr_accessor :name
      self.name = 'TokenManagement_1'

    end
  end
end