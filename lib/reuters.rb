require 'savon'

require 'reuters/credentials'
require 'reuters/version'
require 'reuters/config'
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

  # Configure Savon gem to use the correct version of SOAP
  # and to avoid logging.
  Savon.configure do |config|
    config.soap_version = 2
    config.log = false
  end

  # Set the Namespaces Endpoint
  mattr_accessor :namespaces_endpoint
  @@namespaces_endpoint = 'http://www.reuters.com/ns/2006/05/01'

  # Set the WSDL Endpoint to use to contact the Reuter's API.
  mattr_accessor :wsdl_endpoint
  @@wsdl_endpoint = 'http://api.rkd.reuters.com/schemas/wsdl'

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
  def self.credentials
    yield self::Credentials
  end

end
