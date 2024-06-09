module Business
  class StockMetricCalculator
    def self.calculate(data)
      validate_data(data)
      extract_metrics(data)
    end

    private

    def self.validate_data(data)
      raise ArgumentError, "Invalid data provided for calculating stock metrics." unless data.is_a?(Hash) && data.key?("results")
    end

    def self.extract_metrics(data)
      number_of_days = data["resultsCount"]
      results = data["results"]

      return {} unless number_of_days.positive?

      {
        ticker: data["ticker"],
        number_of_days: number_of_days,
        prices: calculate_prices(results, number_of_days),
        volumes: calculate_volumes(results, number_of_days)
      }
    end

    def self.calculate_prices(results, number_of_days)
      {
        max_price: results.map { |result| result["h"].to_f }.max,
        min_price: results.map { |result| result["l"].to_f }.min,
        avg_price: results.map { |result| result["vw"].to_f }.sum / number_of_days
      }
    end

    def self.calculate_volumes(results, number_of_days)
      {
        max_volume: results.map { |result| result["v"].to_f }.max,
        min_volume: results.map { |result| result["v"].to_f }.min,
        avg_volume: results.map { |result| result["v"].to_f }.sum / number_of_days
      }
    end
  end
end
