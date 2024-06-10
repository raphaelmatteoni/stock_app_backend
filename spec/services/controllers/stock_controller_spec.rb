require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  describe "GET #index" do
    let(:valid_params) do
      {
        ticker: "AAPL",
        start_date: "2023-01-01",
        end_date: "2023-12-31"
      }
    end

    context "when data fetching and calculation succeed" do
      before do
        allow(External::StockService).to receive(:fetch_data).and_return(valid_params)
        allow(Business::StockMetricCalculator).to receive(:calculate).and_return({})
      end

      it "renders the calculated metrics" do
        get :index, params: valid_params
        expect(response).to have_http_status(:success)
      end
    end

    context "when there is an error during data fetching or calculation" do
      before do
        allow(External::StockService).to receive(:fetch_data).and_raise(StandardError, "Failed to fetch data")
      end

      it "rescues the error and renders an internal server error response" do
        get :index, params: valid_params
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end