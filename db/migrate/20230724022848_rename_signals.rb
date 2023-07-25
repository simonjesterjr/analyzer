class RenameSignals < ActiveRecord::Migration[7.0]
  def change
    rename_table :signals, :trading_signals
  end
end
