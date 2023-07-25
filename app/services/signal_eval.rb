class SignalEval
  include Signalable

  attr_reader :market, :portfolio, :breakout_period

  def initialize( market_id, portfolio_id )
    @market = Market.find market_id
    @portfolio = Portfolio.find portfolio_id

    @breakout_period = 55
  end

  def call
    history do |activity|
      price_breakout_load( activity )
      next if activity.signals.size > 0

      signals = []
      signals << price_breakout( activity )
      bollinger_breakout( activity ) do |sig|
        signals << sig
      end
      ma_crossover( activity )
      ma_price_crossover( activity )
      next unless signals.size > 0

      signals.each { |s| Signal.create( s )}
    end
  end

  def price_breakout( activity )
    if activity.high >= highs.max && highs.last == activity.high
      return create_signal( :price_breakout, :long, activity )
    end

    if activity.low <= lows.min && lows.last == activity.high
      create_signal( :price_breakout, :short, activity )
    end
  end

  def bollinger_breakout( activity, &block )
    bb = MarketBollingerBand.find_by( market_id: mkt.id, portfolio_id: portfolio.id, activity_id: activity.id )
    return unless bb

    if activity.high > bb.upper
      yield create_signal( :bollinger_high_breakout, :long, activity, notes: "high price exceeded upper band")
    end

    if activity.close > bb.upper
      yield create_signal( :bollinger_breakout, :long, activity)
    end

    if activity.low < bb.lower
      yield create_signal( :bollinger_low_breakout, :short, activity, notes: "low price broke lower band")
    end

    if activity.close < bb.lower
      yield create_signal( :bollinger_breakout, :short, activity)
    end
  end

  def ma_crossover( activity )
    mma = MarketMovingAverage.find_by( market_id: mkt.id, portfolio_id: portfolio.id, activity_id: activity.id )
    return unless mma

    if mma.ma_55 > mma.ma_75
      yield create_signal( :ma_55_75_crossover, :long, activity )
    end

    if mma.ma_55 > mma.ma_110
      yield create_signal( :ma_55_110_crossover, :long, activity )
    end

    if mma.ma_55 < mma.ma_75
      yield create_signal( :ma_55_75_crossover, :long, activity )
    end

    if mma.ma_55 > mma.ma_110
      yield create_signal( :ma_55_110_crossover, :long, activity )
    end

  end

  def price_breakout_load( activity )
    highs << activity.high
    lows << activity.low
    highs.shift if highs.size > breakout_period
    lows.shift if highs.size > breakout_period
  end

  def history
    Activity.history( portfolio.id, market.id ).order( date: :asc ).each do |activity|
      yield activity
    end
  end

  def highs
    @highs = []
  end

  def lows
    @lows = []
  end

end
