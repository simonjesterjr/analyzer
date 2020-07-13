class HistoricalTest < InteractorBase

  def call

  end

  def portfolio
    @portfolio ||= Portfolio.find( context.portfolio_id )
  end

  def markets
    @markets ||= portfolio.markets
  end
end
