module Reuters
  module Client
    # Performs a Fundamentals Reuters API request. Fundamentals
    # can be used to retrieve snapshot information about a specific
    # company ID and Ticker.
    #
    # @example Making a fundamentals request
    #   req = Reuters::Client::Fundamentals.new
    #   msg = Reuters::Builder.new
    #   puts req.operations #=> [:get_snapshot_reports_1, ...]
    #   response = req.get_snapshot_reports_1(msg, {
    #     'companyId' => id,
    #     'companyIdType' => type,
    #     'countryCode' => code,
    #     'includeMedians' => medians
    #   })
    class Fundamentals < Base
    end
  end
end