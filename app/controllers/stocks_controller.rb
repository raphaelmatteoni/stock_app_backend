class StocksController < ApplicationController

  def index
    # ticker = params[:ticker]
    ticker = "AAPL"
    start_date = '2023-01-01'
    end_date = '2023-12-31'
    url = "https://api.polygon.io/v2/aggs/ticker/#{ticker}/range/1/day/#{start_date}/#{end_date}?apiKey=taIMgMrmnZ8SUZmdpq9_7ANRDxw3IPIx"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    render json: JSON.parse(response)
  end
end
