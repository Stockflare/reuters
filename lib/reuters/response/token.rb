module Reuters
  module Response
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