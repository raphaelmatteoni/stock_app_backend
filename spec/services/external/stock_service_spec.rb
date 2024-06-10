require 'rails_helper'

RSpec.describe External::StockService, type: :service do
  describe '.fetch_data' do
    let(:ticker) { 'AAPL' }
    let(:start_date) { '2023-01-01' }
    let(:end_date) { '2023-12-31' }
    let(:response_body) { '{"status":"success","data":[{"h":100,"l":90,"vw":95}]}'.freeze }
    let(:parsed_response) { JSON.parse(response_body) }

    before do
      allow(Net::HTTP).to receive(:get).and_return(response_body)
    end

    it 'fetches and parses data successfully' do
      result = described_class.fetch_data(ticker: ticker, start_date: start_date, end_date: end_date)
      expect(result).to eq(parsed_response)
    end

    context 'when there is an error parsing the response due to invalid date parameters' do
      let(:expected_prefix) { "Error parsing the API response:" }
      let(:error_message) { "Could not parse the time parameter: 'from'. Use YYYY-MM-DD or Unix MS Timestamps" }
    
      before do
        allow(Net::HTTP).to receive(:get).and_raise(JSON::ParserError.new(error_message))
      end
    
      it 'raises a StandardError with the correct prefix in the message' do
        expect { described_class.fetch_data(ticker: ticker, start_date: 'invalid-date', end_date: end_date) }.to raise_error(StandardError) do |error|
          expect(error.message).to match(expected_prefix)
        end
      end
    end    

    context 'when there is another error during data fetching' do
      let(:expected_prefix) { "Error fetching data from the API:" }
      let(:error_message) { "Error fetching data from the API: Could not connect to server" }

      before do
        allow(Net::HTTP).to receive(:get).and_raise(StandardError.new(error_message))
      end

      it 'raises a StandardError with the correct message' do
        expect { described_class.fetch_data(ticker: ticker, start_date: start_date, end_date: end_date) }.to raise_error(StandardError) do |error|
          expect(error.message).to match(expected_prefix)
        end
      end
    end
  end
end
