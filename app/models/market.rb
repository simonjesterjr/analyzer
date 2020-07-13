class Market < ApplicationRecord
    has_and_belongs_to_many :portfolios

    attr_accessor :max_open, :min_open, :max_close, :min_close,
                  :max, :min, :volume, :vix

    enum period: [ :day, :week, :hour, :tick ]



    def data
      result = PeriodData.where( market_id: id )
      result.map{ |pd| pd.period == self.period }
    end

    # "2020-07-01": {
    #     "1. open": "120.2700",
    #     "2. high": "121.2250",
    #     "3. low": "118.3700",
    #     "4. close": "118.5400",
    #     "5. adjusted close": "118.5400",
    #     "6. volume": "4657168",
    #     "7. dividend amount": "0.0000",
    #     "8. split coefficient": "1.0000"
    # }
    def load_hx_data
      result = retrieve_hx
      result[:"Time Series (Daily)"].each do |key, ts|
        puts key
        puts ts
        PeriodData.create!(
          timestamp: key.to_s,
          open: normalize( ts[:"1. open"] ),
          high: normalize( ts[:"2. high"] ),
          low: normalize( ts[:"3. low"] ),
          close: normalize( ts[:"4. close"] ),
          volume: ts[:"6.volume"],
          market_id: id,
          period: Market.periods[period]
        )
      end
    end

    def retrieve_hx
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=#{trading_symbol.upcase}&outputsize=full&apikey=demo"
      result = HTTParty.get( url, format: :plain )
      JSON.parse result, symbolize_names: true
    end

    def normalize(val)
      (val.to_f * 10000).to_i
    end
end
