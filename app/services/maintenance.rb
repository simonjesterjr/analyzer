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
      atr_results = TechnicalAnalysis::Atr.calculate( acts, period: 17 )
      mkt.activities.where( atr: 0.0 ).each do |act|
        val = atr_results.detect{ |a| a.date_time == act.date }
        act.update( atr: val.atr ) if val
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
