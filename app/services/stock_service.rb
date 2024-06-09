class StockService
  require "net/http"

  def self.fetch_data(ticker:, start_date:, end_date:)
    url = "#{ENV['POLYGON_BASE_URL']}#{ticker}/range/1/day/#{start_date}/#{end_date}?apiKey=#{ENV['POLYGON_API_KEY']}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end
end