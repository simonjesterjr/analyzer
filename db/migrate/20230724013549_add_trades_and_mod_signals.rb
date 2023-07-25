class AddTradesAndModSignals < ActiveRecord::Migration[7.0]
  def change
    add_column :positions, :motivation, :integer, default: 0

    create_table :trades do |t|
      t.integer               :signal_id
      t.float                 :stop
      t.boolean               :for_test
      t.integer               :units
      t.string                :action_description
      t.boolean               :executed
      t.float                 :signal_price
      t.float                 :actual_price
      t.float                 :additional_fees
    end

    remove_column :signals, :stop, :float, default: 0.0
    remove_column :signals, :units, :integer, default: 0
    remove_column :signals, :test, :boolean
  end
end
