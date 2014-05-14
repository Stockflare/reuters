module Reuters
  module Response
    class Token

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