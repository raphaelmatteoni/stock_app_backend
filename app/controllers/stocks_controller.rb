class StocksController < ApplicationController
  include ErrorHandlingConcern

  def index
    data = External::StockService.fetch_data(
      ticker: params[:ticker],
      start_date: params[:start_date],
      end_date: params[:end_date]
    )

    result = Business::StockMetricCalculator.calculate(data)

    render json: result
  end
end
