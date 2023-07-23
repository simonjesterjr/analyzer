class SignalEval
  attr_reader :market, :portfolio

  def initialize( market_id, portfolio_id )
    @market = Market.find market_id
    @portfolio = Portfolio.find portfolio_id
  end

  def call
    Activity.history( portfolio.id, market.id ).order( date: :asc )
  end

end
