class PortfoliosController < ApplicationController

  def index
    @portfolios = Portfolio.all
  end

  def create
    @portfolio = Portfolio.create( portfolio_params )

    redirect_to portfolios_path
  end

  def show
    @portfolio = Portfolio.find( params[:id] )
    @markets = Market.all
  end

  def destroy
    @portfolio = Portfolio.find( params[:id] )
    @portfolio.destroy

    redirect_to portfolios_path
  end

  def historical_test
    context = HistoricalTest.call( portfolio_id: @params[:id] )

    redirect_to portfolio_path( id: params[:id] )
  end



  def update
    @portfolio = Portfolio.find( params[:id] )
    @portfolio.name = portfolio_params[:name]
    @portfolio.description = portfolio_params[:description]
    @portfolio.market_ids = portfolio_params[:markets]

    flash[:notice] = "portfolio updated" if @portfolio.save
    redirect_to portfolio_path( id: params[:id] )
  end



  private
    def portfolio_params
      params.require(:portfolio).permit( :name,
                                         :description,
                                         markets: [] )
    end

end
