class CreateActivity < ActiveRecord::Migration[7.0]
  def change
    # Date,NumericDeliveryMonth,       Open,       High,        Low,      Close,  Volume
    # 20230721,    54,194.10000000,194.97000000,191.23000000,191.94000000,  719178
    create_table :activities do |t|
      t.integer             :market_id
      t.date                :date
      t.float               :open
      t.float               :high
      t.float               :low
      t.float               :close
      t.integer             :volume
      t.integer             :oi
      t.integer             :numeric_delivery_month
      t.float               :atr, default: 0.00

      t.timestamps
    end

    drop_table :signals if table_exists?( :signals )

    create_table :signals do |t|
      t.integer             :units
      t.string              :action_description
      t.string              :triggers
      t.boolean             :test
      t.integer             :direction
      t.float               :stop

      t.timestamps
    end

    create_table :positions do |t|
      t.integer             :portfolio_id
      t.integer             :units
      t.float               :execution_price
      t.float               :order_price
      t.string              :action_description
      t.float               :original_stop
      t.float               :updated_stop

      t.timestamps
    end

    add_column :markets, :tick_size, :float
    add_column :markets, :tick_value, :float
  end
end
