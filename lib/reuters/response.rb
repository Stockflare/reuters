require 'reuters/response/token'
require 'reuters/response/fundamentals'
require 'reuters/response/search'

module Reuters
  # This module acts as a Namespace for client-based
  # response classes. For example, the Token client has
  # a corresponding Token response class, which is used
  # to automagically parse responses from the Reuters API.
  module Response
  end
end