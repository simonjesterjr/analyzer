class CreateMarkets < ActiveRecord::Migration[6.0]
  def change
    create_table :markets do |t|
      t.string        :name, null: false
      t.string        :trading_symbol, null: false
      t.integer       :period, default: 0
      t.string        :trading_market, null: false

      t.timestamps
    end
  end
end
