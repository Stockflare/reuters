module Reuters
  module Response
    # Builds the response received from the Reuters API
    # for a Fundamentals based request.
    #
    # @note This class is designed to parse the hash that
    #   is returned from Savon after a successful request
    #   to the Reuters API.
    class Fundamentals

      delegate :[], to: :@data

      attr_writer :data

      def initialize(payload)
        type = payload.keys.first
        send(type, payload[type])
      end

      private

      def get_snapshot_reports_response_1(response)
        data = response
      end

    end
  end
end