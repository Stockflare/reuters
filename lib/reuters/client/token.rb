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

      # @!attribute [r] expires_at
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

      delegate :token, :expires_at, to: :current_response

      delegate :username, :password, :app_id, to: :credentials

      # Send a correctly formatted request to the Reuter's
      # API. This call overloads the basic #request method
      # by making an unauthenticated API call.
      #
      # @note This request method calls the Savon Client #call
      #       method.
      #
      # @see http://savonrb.com/version2/requests.html
      #
      # @return [Object] The Savon Response object.
      def request(type, opts = {})
        response.new client.call(type, opts.deep_merge(
          attributes: { 'xmlns' => namespace.endpoint })).body
      end

      # Authenticates with Reuters and automatically
      # attempts to retieve a new token from the Reuter's API.
      #
      # @return [Token] an initialized instance of {Token}
      def authenticate
        @response = request :create_service_token_1, message: {
          'ApplicationID' => app_id,
          'Username' => username,
          'Password' => password,
          :attributes! => { 'ApplicationID' => { 'xmlns' => common.endpoint } }
        }
      end

      private

      def credentials
        Reuters::Credentials
      end

      def current_response
        if @response && @response.expires_at > Time.now
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