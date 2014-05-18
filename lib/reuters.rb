require 'savon'

require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/string/inflections'
require 'active_support/inflector'

require 'reuters/namespaces'
require 'reuters/wsdls'
require 'reuters/credentials'
require 'reuters/version'
require 'reuters/builder'
require 'reuters/response'
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

  # @!attribute namespaces_endpoint
  #   @!scope class
  #   The endpoint that will be used to contact Reuters to determine
  #   the fully resolved namespaces.
  #   @return [String] The configured namespace endpoint.

  # @!attribute wsdl_endpoint
  #   @!scope class
  #   The WSDL endpoint that will be used to contact Reuters.
  #   @return [String] The configured WSDL endpoint.

  # @!attribute debug
  #   @!scope class
  #   Determines if debugging mode is enabled for the Reuters gem.
  #   If enabled, any Reuters API requests will debug to STDOUT.
  #   @return [Boolean] False if disabled, true if enabled.

  # Sets whether debugging is enabled for the Reuters API calls.
  # By default, this value is set to false as to not make any output
  # unnecessarily noisy.
  mattr_accessor :debug
  self.debug = false

  # Set the default Reuters API namespace endpoint. This is the
  # standard default for most API requests and shouldn't
  # really need to be changed.
  mattr_accessor :namespaces_endpoint
  self.namespaces_endpoint = 'http://www.reuters.com/ns'

  # Set the default Reuter's API WSDL endpoint. This endpoint
  # sets compatibility for SOAP 1.1 requests and will need to
  # be changed if you wish to use SOAP 1.2 with the Reuter's API.
  mattr_accessor :wsdl_endpoint
  self.wsdl_endpoint = 'http://api.rkd.reuters.com/schemas'

  # Sets Reuters specific acronyms, such as ISIN and RIC.
  # The API requests these acronyms to be in uppercase
  # rather than camelcase.
  mattr_accessor :reuters_acronyms
  def self.reuters_acronyms=(val)
    ActiveSupport::Inflector.inflections do |i|
      val.each { |v| i.acronym v }
    end
  end

  # Set the default Reuters Acronyms that consistently appear
  # throughout the API.
  self.reuters_acronyms = %w(ID RIC ISIN)

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
