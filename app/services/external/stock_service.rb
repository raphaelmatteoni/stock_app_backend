module External
  class StockService
    require "net/http"

    def self.fetch_data(ticker:, start_date:, end_date:)
      uri = build_uri(ticker, start_date, end_date)
      fetch_and_parse_data(uri)
    end

    private

    def self.build_uri(ticker, start_date, end_date)
      url = "#{ENV['POLYGON_BASE_URL']}#{ticker}/range/1/day/#{start_date}/#{end_date}?apiKey=#{ENV['POLYGON_API_KEY']}"
      URI(url)
    end

    def self.fetch_and_parse_data(uri)
      begin
        response = Net::HTTP.get(uri)
        JSON.parse(response)
      rescue JSON::ParserError => e
        raise StandardError, "Error parsing the API response: #{e.message}"
      rescue StandardError => e
        raise StandardError, "Error fetching data from the API: #{e.message}"
      end
    end
  end
end
