require 'reuters/namespaces/search/equity'

module Reuters
  module Namespaces
    # Represents the base search namespaces. Note that because
    # search is quite a broad namespace inside the Reuters api,
    # it is better to use a more specific namespace such as
    # {Reuters::Namespaces::Search::Equity}.
    module Search

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
      self.name = 'Search'

      # Define a custom name or endpoint that Reuters uses
      # to define XML Namespaces inside the request body.
      #
      # @example Defining a custom namespace
      #   str = Reuters::Namespaces::Search.define(:equity_quote, :query_spec, 1)
      #   puts str #=> "http://.../Search/EquityQuote_QuerySpec_1"
      # @param [String] *strs to convert into a valid namespace
      #
      # @return [String] A full namespaced endpoint with a underscore
      #   separated camelized definition.
      def self.define(*strs)
        str = strs.map { |s| s.to_s.camelize }.join('_')
        "#{endpoint}/#{str}"
      end

    end
  end
end