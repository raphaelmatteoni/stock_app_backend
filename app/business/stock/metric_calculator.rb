module Stock
  class MetricCalculator
    def self.calculate(data)
      number_of_days = data["resultsCount"]
      results = data["results"]
      metrics = {
        max_price: results.map { |item| item["h"].to_f }.max,
        min_price: results.map { |item| item["l"].to_f }.min,
        avg_price: results.map { |item| item["vw"].to_f }.sum / number_of_days,
        max_volume: results.map { |item| item["v"].to_f }.max,
        min_volume: results.map { |item| item["v"].to_f }.min,
        avg_volume: results.map { |item| item["v"].to_f }.sum / number_of_days
      }

      metrics
    end
  end
end