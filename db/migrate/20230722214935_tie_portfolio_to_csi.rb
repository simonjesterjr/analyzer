class TiePortfolioToCsi < ActiveRecord::Migration[7.0]
  def change
    add_column :portfolios, :csi_portfolio, :string
  end
end
