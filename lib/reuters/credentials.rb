module Reuters

  # The {Credentials} module handles storing the
  # configured credentials for the {Reuters} gem.
  #
  # @example Configuring credentials.
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
  module Credentials

    # @!attribute username
    #   @!scope class
    #   The username to use to authenticate against the
    #   Reuter's API with.
    #   @return [String, Nil] The configured username, or nil if
    #     none is set.

    # @!attribute password
    #   @!scope class
    #   The password to use to authenticate against the
    #   Reuter's API with.
    #   @return [String, Nil] The configured password, or nil if
    #     none is set.

    # @!attribute app_id
    #   @!scope class
    #   The application ID to use for all requests to the
    #   Reuter's API.
    #   @return [String, Nil] The configured appication ID, or nil if
    #     none is set.

    mattr_accessor :username
    self.username = nil

    mattr_accessor :password
    self.password = nil

    mattr_accessor :app_id
    self.app_id = nil

    # Yields the configured credentials to connect to the
    # Reuter's API with.
    #
    # @yield [username, password, app_id] Yields authentication information.
    #
    # @yieldparam [String, Nil] username configured, or nil if one is not set.
    # @yieldparam [String, Nil] password configured, or nil if one is not set.
    # @yieldparam [String, Nil] app_id configured, or nil if one is not set.
    def self.details
      yield @@username, @@password, @@app_id
    end

    def self.to_h
      { username: username, password: password, app_id: app_id }
    end

    def self.configure
      yield self
    end

  end

end