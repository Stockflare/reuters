require 'savon'

require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/hash/deep_merge'

require 'reuters/namespaces'
require 'reuters/wsdls'
require 'reuters/credentials'
require 'reuters/version'
require 'reuters/client'

# Ruby Gem for interacting with the Thomson Reuters
# Knowledge Direct API.
#
# @example Configuring the Reuters Gem.
#   Reuters.configure do |config|
#     config.credentials do |login|
#       # Set username
#       login.username = "my_username"
#       # Set my password
#       login.password = "my_super_secret_password"
#       # Set application ID
#       login.application_id = "application_id"
#     end
#   end
module Reuters

  mattr_accessor :namespaces_endpoint
  self.namespaces_endpoint = 'http://www.reuters.com/ns/2006/05/01/webservices/rkd'

  mattr_accessor :wsdl_endpoint
  self.wsdl_endpoint = 'http://api.rkd.reuters.com/schemas/'

  # Helper to configure the Reuters gem.
  #
  # @yield [Reuters] Yields the {Reuters} module.
  def self.configure
    yield self
  end

  # Yield the {Reuters::Credentials} class as a configurable
  # block. This block helps clients to set their credentials
  # easily.
  #
  # @yield [Reuters::Credentials] Yields the {Credentials} module.
  def self.credentials(&block)
    self::Credentials.configure(&block)
  end

end
