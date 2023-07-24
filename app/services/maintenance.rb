class Maintenance
  attr_reader :portfolio, :clean

  def initialize( portfolio_id, clean = false )
    @clean = clean
    @portfolio = Portfolio.find( portfolio_id )
    @count = 0
  end

  def call
    data = DataFromCsi.new( portfolio.id, clean )
    data.call do |message|
      add_message message
    end

    portfolio.markets.each do |mkt|
      acts = mkt.activities.map(&:to_analysis_hash)
      atr_results = TechnicalAnalysis::Watr.calculate( acts, period: 17 )
      mkt.activities.where( atr: 0.0 ).each do |act|
        val = atr_results.detect{ |a| a.date_time == act.date }
        act.update( atr: val.watr ) if val
      end

      MarketMovingAverage.where( market_id: mkt.id, portfolio_id: portfolio.id ).delete_all
      ma_55s = TechnicalAnalysis::Sma.calculate( acts, period: 55, price_key: :close)
      ma_75s = TechnicalAnalysis::Sma.calculate( acts, period: 75, price_key: :close)
      ma_110s = TechnicalAnalysis::Sma.calculate( acts, period: 110, price_key: :close)

      mkt.activities.order( date: :asc ).each do |act|
        ma_55 = ma_55s.detect{ |a| a.date_time == act.date }
        ma_75 = ma_75s.detect{ |a| a.date_time == act.date }
        ma_110 = ma_110s.detect{ |a| a.date_time == act.date }
        MarketMovingAverage.create( time: act.date,
                                    ma_55: ma_55&.sma || 0.0,
                                    ma_75: ma_75&.sma || 0.0,
                                    ma_110: ma_110&.sma || 0.0,
                                    market_id: mkt.id,
                                    activity_id: act.id,
                                    portfolio_id: portfolio.id )
      end

      MarketBollingerBand.where( market_id: mkt.id, portfolio_id: portfolio.id ).delete_all
      bbs = TechnicalAnalysis::Bb.calculate( acts, period: 55, standard_deviations: 2, price_key: :close)
      mkt.activities.order( date: :asc ).each do |act|
        bb = bbs.detect{ |a| a.date_time == act.date }
        MarketBollingerBand.create( time: act.date,
                                    upper: bb.upper_band,
                                    lower: bb.lower_band,
                                    middle: bb.middle_band,
                                    market_id: mkt.id,
                                    activity_id: act.id,
                                    portfolio_id: portfolio.id )
      end
      add_message "#{mkt.trading_symbol} analysis complete"
    end

    add_message "#{portfolio.name} maintenance complete"
    messages.join("/n")
  end

  def messages
    @messages ||= []
  end

  def add_message( txt )
    messages << "#{@count += 1}. #{txt}"
  end

end
