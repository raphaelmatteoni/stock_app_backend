# Stock App Backend

## Description
This is a Ruby on Rails application that calculates stock metrics based on a specified ticker and date range. It uses external services to fetch market data and performs calculations to determine maximum, minimum, and average prices, as well as maximum, minimum, and average volumes.

## Prerequisites
Docker and Docker Compose installed on your system.

## Setup
1. Clone this repository to your local environment.
2. Navigate to the project directory.
3. To build and start the necessary containers, use the following command:

```sh
docker-compose up --build
```

## Running Tests
To run the project's tests, use the following command:

```sh 
docker-compose run web bundle exec rspec
```

This will execute all unit and integration tests defined in the project.

## Consuming the API
To consume the API and obtain stock metrics, make a GET request to the /stocks endpoint with the parameters ticker, start_date, and end_date. For example:

[http://localhost:3000/stocks?ticker=AAPL&start_date=2023-01-01&end_date=2023-12-31]

This request will return a JSON object with the calculated metrics for the AAPL ticker within the specified period, similar to:

```json
{
  "ticker": "AAPL",
  "number_of_days": 250,
  "prices": {
    "max_price": 199.62,
    "min_price": 124.17,
    "avg_price": 172.4715832
  },
  "volumes": {
    "max_volume": 154338835,
    "min_volume": 24018404,
    "avg_volume": 59153887.104
  }
}
```
