class AddTestRunToSignal < ActiveRecord::Migration[7.0]
  def change
    add_column :signals, :run_id, :uuid
    add_column :signals, :activity_id, :integer
    add_column :activities, :portfolio_id, :integer

    add_index :markets, :trading_symbol
    add_index :activities, [:portfolio_id, :market_id, :date, :numeric_delivery_month], unique: true, name: 'index_activities_on_portfolio_market_date_delivery'
    add_index :activities, :date
  end
end
