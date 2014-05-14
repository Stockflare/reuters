module Reuters
  module Client
    class Fundamental < Base

      def initialize
        @token = Reuters::Client::Token.new
      end

      def snapshot(id, type, code, medians = true)
        @response = request :get_snapshot_reports_1, attributes: {
          'companyId' => id,
          'companyIdType' => type,
          'countryCode' => code,
          'includeMedians' => medians
        }
      end

    end
  end
end