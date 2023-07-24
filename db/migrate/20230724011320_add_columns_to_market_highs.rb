class AddColumnsToMarketHighs < ActiveRecord::Migration[7.0]
  def change
    add_column :market_highs, :low_close, :float, default: 0.0
    add_column :market_highs, :low_low, :float, default: 0.0
  end
end
