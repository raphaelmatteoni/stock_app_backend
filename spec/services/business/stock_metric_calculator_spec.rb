require 'rails_helper'

RSpec.describe Business::StockMetricCalculator, type: :service do
  describe '.calculate' do
    let(:data) do
      {
        "ticker": "AAPL",
        "queryCount": 3,
        "resultsCount": 3,
        "adjusted": true,
        "results": [
          {"v": 112117471, "vw": 125.725, "o": 130.28, "c": 125.07, "h": 130.9, "l": 124.17, "t": 1672722000000, "n": 1021065},
          {"v": 89100633, "vw": 126.6464, "o": 126.89, "c": 126.36, "h": 128.6557, "l": 125.08, "t": 1672808400000, "n": 770042},
          {"v": 80716808, "vw": 126.0883, "o": 127.13, "c": 125.02, "h": 127.77, "l": 124.76, "t": 1672894800000, "n": 665458}
        ],
        "status": "OK",
        "request_id": "3aa0a3f21a1d329e7e01307042646f96",
        "count": 3
      }.with_indifferent_access
    end

    before do
      allow(described_class).to receive(:validate_data).with(data).and_return(true)
      allow(described_class).to receive(:extract_metrics).with(data).and_return({})
    end

    it 'calls validate_data and extract_metrics' do
      expect(described_class).to receive(:validate_data).with(data).ordered
      expect(described_class).to receive(:extract_metrics).with(data).ordered
      described_class.calculate(data)
    end
  end

  describe '.validate_data' do
    it 'raises an ArgumentError if data is not a Hash or does not contain "results"' do
      expect { described_class.validate_data([]) }.to raise_error(ArgumentError, "Invalid data provided for calculating stock metrics.")
    end
  end

  describe '.extract_metrics' do
    let(:data) do
      {
        "ticker": "AAPL",
        "queryCount": 3,
        "resultsCount": 3,
        "adjusted": true,
        "results": [
          {"v": 112117471, "vw": 125.725, "o": 130.28, "c": 125.07, "h": 130.9, "l": 124.17, "t": 1672722000000, "n": 1021065},
          {"v": 89100633, "vw": 126.6464, "o": 126.89, "c": 126.36, "h": 128.6557, "l": 125.08, "t": 1672808400000, "n": 770042},
          {"v": 80716808, "vw": 126.0883, "o": 127.13, "c": 125.02, "h": 127.77, "l": 124.76, "t": 1672894800000, "n": 665458}
        ],
        "status": "OK",
        "request_id": "3aa0a3f21a1d329e7e01307042646f96",
        "count": 3
      }.with_indifferent_access
    end

    it 'calculates the correct metrics' do
      result = described_class.extract_metrics(data)
      expect(result[:prices][:max_price]).to eq(130.9)
      expect(result[:prices][:min_price]).to eq(124.17)
      expect(result[:prices][:avg_price]).to eq(126.15323333333333)
      expect(result[:volumes][:max_volume]).to eq(112117471)
      expect(result[:volumes][:min_volume]).to eq(80716808)
      expect(result[:volumes][:avg_volume]).to eq(93978304.0)
    end
  end
end
