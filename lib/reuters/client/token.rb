module Reuters
  module Client
    # Retrieves a new Token from the Reuter's API using the
    # credentials that have been passed in to the constructor.
    #
    # @example Retrieving a new token
    #  credentials = { username: "bob", password: "hello", app_id: "1234" }
    #  authentication = Reuters::Client::Token.new credentials
    #  authentication.token #=> "raj2ja89djf98aj3jjoadjowajdoiaj"
    class Token < Base

      # @!attribute [r] token
      #   The token that has been retrieved from the Reuter's API.
      #   @return [String, Nil] the token contents, or nil if not set.

      # @!attribute [r] expires_at
      #   The timestamp at which the associated token will expire.
      #   @return [Integer, Nil] the expiry time of the token,
      #     or nil if not set.

      attr_reader :token

      attr_reader :expires_at

      # Authenticates with Reuters and automatically
      # attempts to retieve a new token from the Reuter's API.
      #
      # @param [Hash] creds to be used to authenticate.
      #
      # @option creds [String] :username Username to be used.
      # @option creds [String] :password Password to be used.
      # @option creds [String] :app_id   Application ID to be used.
      #
      # @return [Token] an initialized instance of {Token}
      def authenticate(creds = Reuters::Credentials.to_h)

        message = {
          'ApplicationID' => creds[:app_id],
          'Username' => creds[:username],
          'Password' => creds[:password],
          :attributes! => {
            'ApplicationID' => {
              'xmlns' => common.endpoint
            }
          }
        }

        response = request :create_service_token_1, message: message

        # puts response.inspect

        @token = response[:create_service_token_response_1][:token]
        @expires_at = response[:create_service_token_response_1][:expiration]

      end

    end
  end
end