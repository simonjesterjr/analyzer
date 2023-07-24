class AddMetricsColumnToActivities < ActiveRecord::Migration[7.0]
  def up
    execute <<~SQL
      CREATE TABLE market_moving_average ( time TIMESTAMPTZ NOT NULL,
                                           market_id integer NOT NULL,
                                           portfolio_id integer NOT NULL,
                                           activity_id integer NOT NULL,
                                           ma_55 DOUBLE PRECISION,
                                           ma_75 DOUBLE PRECISION,
                                           ma_110 DOUBLE PRECISION );
    SQL
  end

  def down
    drop_table :market_moving_averages if table_exists?( :market_moving_averages )
  end
end
