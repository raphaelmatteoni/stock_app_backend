class StocksController < ApplicationController
  def index
    result = StockService.fetch_data(
      ticker: params[:ticker],
      start_date: params[:start_date],
      end_date: params[:end_date]
    )
    render json: result
  end
end
