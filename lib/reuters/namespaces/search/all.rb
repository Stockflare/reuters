module Reuters
  module Namespaces
    module Search
      # Represents the Search All namespace that can be
      # used to query for information about all types of listings
      module All

        # @!parse include Base

        include Base

        # Year for the Search Equity endpoint.
        mattr_accessor :year
        self.year = '2006'

        # Month for the Search Equity endpoint.
        mattr_accessor :month
        self.month = '05'

        # Day for the Search Equity endpoint.
        mattr_accessor :day
        self.day = '01'

        # Name for the Search Equity endpoint.
        mattr_accessor :name
        self.name = 'Search/Searchall_1'

      end
    end
  end
end
