module Reuters
  module Response
    # Builds the response received from the Reuters API
    # for a Token based request. This class will parse
    # the token contens and the expiry time and skip
    # any other content in the response.
    #
    # @note This class is designed to parse the hash that
    #   is returned from Savon after a successful request
    #   to the Reuters API.
    class Token

      # @!attribute [r] token
      #   The token that has been retrieved from the Reuter's API.
      #   @return [String, Nil] the token contents, or nil if not set.

      # @!attribute [r] expires_at
      #   The timestamp at which the associated token will expire.
      #   @return [Time, Nil] the expiry time of the token,
      #     or nil if not set.

      attr_reader :token

      attr_reader :expires_at

      def initialize(payload)
        type = payload.keys.first
        send(type, payload[type])
      end

      def create_service_token_response_1(body)
        @expires_at = Time.parse(body[:expiration])
        @token = body[:token]
      end

    end
  end
end