class DataFromCsi
  attr_reader :portfolio, :clean

  def initialize( portfolio_id, clean = false )
    @clean = clean
    @portfolio = Portfolio.find( portfolio_id )
  end

  def call
    portfolio.markets.each do |mkt|
      mkt.activities.delete_all if clean

      data = DataToJson.new( portfolio.csi_portfolio, mkt.trading_symbol )
      data.call
      existing = mkt.activities.pluck(:date)
      results = data.results.reject{ |d| existing.include?( d[:date] ) }
      results.each do |hash|
        hash.merge!( portfolio_id: @portfolio.id )
        mkt.activities << Activity.new( hash )
      end
      yield "#{mkt.trading_symbol} loaded"
    end
  end

  def path
    "#{local_path}/#{portfolio}/#{symbol}.txt"
  end

  def local_path
    "/Users/johnkoisch/Library/Application Support/CrossOver/Bottles/sawtooth_trading/drive_c/UA/Data"
  end
end