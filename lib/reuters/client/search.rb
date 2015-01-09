require 'reuters/client/search/base'
require 'reuters/client/search/equity'
require 'reuters/client/search/all'

module Reuters
  module Client
    # Search is a namespace for sub-clients, such as
    # Equity-based searches on the Reuters API. This
    # client cannot be initialized directly.
    # A specific sub-client should be initialized.
    #
    # @note Each client behaves in the same way
    #  as every other client.
    #
    # @example Initializing an Equity Search Client
    #  cli = Reuters::Client::Search::Equity.new
    module Search
    end
  end
end
