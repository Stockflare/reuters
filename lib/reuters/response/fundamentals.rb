module Reuters
  module Response
    class Fundamentals

      def initialize(payload)
        @payload = payload[:get_snapshot_reports_response_1]
      end

      def [](key)
        @payload[key]
      end

    end
  end
end