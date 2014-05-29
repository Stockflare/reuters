module Reuters
  module Client
    # Retrieves a new Token from the Reuter's API using the
    # credentials that have been globally configured.
    #
    # @example Retrieving a new token
    #   Reuters::Credentials.configure do |c|
    #     c.username = 'username'
    #     c.password = 'pass'
    #     c.app_id = 'MyAppID'
    #   end
    #   authentication = Reuters::Client::Token.new
    #   authentication.token #=> "raj2ja89djf98aj3jjoadjowajdoiaj"
    class Token < Base

      # @!attribute [r] token
      #   The token that has been retrieved from the Reuter's API.
      #   @return [String, Nil] the token contents, or nil if not set.

      # @!attribute [r] expiration
      #   The timestamp at which the associated token will expire.
      #   @return [Integer, Nil] the expiry time of the token,
      #     or nil if not set.

      # @!attribute [r] username
      #   The username that will be used to authenticate with
      #   the Reuter's api.
      #   @return [String, Nil] the username, or nil if one has
      #     not been configured.

      # @!attribute [r] password
      #   The password that will be used to authenticate with
      #   the Reuter's api.
      #   @return [String, Nil] the password, or nil if one has
      #     not been configured.

      # @!attribute [r] app_id
      #   The application id that will be used to authenticate with
      #   the Reuter's api.
      #   @return [String, Nil] the application id, or nil if one has
      #     not been configured.

      delegate :token, :expiration, to: :current_response

      delegate :username, :password, :app_id, to: :credentials

      # Override {Base} constructor and avoid setting a token
      # as it will crash the client.
      def initialize
        @wsdl = Reuters::Wsdls.const_get client_name
        @namespace = Reuters::Namespaces.const_get client_name
      end

      # Build the authentication message that will be sent to Reuters.
      #
      # @return [Hash] the contents of the body of the message.
      def message
        Reuters::Builder.new do |body|
          body.application_id = app_id
          body.username = username
          body.password = password
          body.application_id({ xmlns: common.endpoint }, false)
        end
      end

      # Authenticates with Reuters and automatically
      # attempts to retieve a new token from the Reuter's API.
      #
      # @return [Token] an initialized instance of {Token}
      def authenticate
        @response = create_service_token_1(message, {}, false)
      end

      def header
        response = current_response
        Reuters::Builder.new do |body|
          body.authorization.application_id = app_id
          body.authorization.token = response.token
          body.authorization({ 'xmlns' => common.endpoint }, false)
        end
      end

      private

      def credentials
        Reuters::Credentials
      end

      def current_response
        if @response && Time.parse(@response.expiration) > Time.now
          @response
        else
          fail 'Token has expired.'
        end
      rescue
        authenticate
      end

    end
  end
end