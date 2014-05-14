module Reuters
  module Client
    class Fundamental

      def initialize
        @token = Reuters::Client::Token.new
      end

      def snapshot(id, type, code, medians=true)
        @response = request :get_snapshot_reports_1, {
          soap_header: {
            'Authorization' => {
              'ApplicationID' => Reuters::Credentials.app_id,
              'Token' => @token.token
            },
            :attributes! => {
              'Authorization' => { 'xmlns' => common.endpoint }
            }
          },
          attributes: {
            'companyId' => id,
            'companyIdType' => type,
            'countryCode' => code,
            'includeMedians' => medians
          }
        }
      end

    end
  end
end