class AddTestRunToSignal < ActiveRecord::Migration[7.0]
  def change
    add_column :signals, :run_id, :uuid
    add_column :signals, :activity_id, :integer
    add_column :activities, :portfolio_id, :integer

    add_index :markets, :trading_symbol
    add_index :activities, [:portfolio_id, :market_id], unique: true
    add_index :activities, :date
  end
end
