class Renaming < ActiveRecord::Migration[7.0]
  def change
    rename_table :market_moving_average, :market_moving_averages

    execute <<~SQL
      CREATE TABLE market_bollinger_bands ( time TIMESTAMPTZ NOT NULL,
                                            market_id integer NOT NULL,
                                            portfolio_id integer NOT NULL,
                                            activity_id integer NOT NULL,
                                            upper DOUBLE PRECISION DEFAULT 0.0,
                                            lower DOUBLE PRECISION DEFAULT 0.0,
                                            middle DOUBLE PRECISION DEFAULT 0.0 );
    SQL

    execute <<~SQL
      CREATE TABLE market_highs ( time TIMESTAMPTZ NOT NULL,
                                  market_id integer NOT NULL,
                                  portfolio_id integer NOT NULL,
                                  activity_id integer NOT NULL,
                                  high_close DOUBLE PRECISION DEFAULT 0.0,
                                  high_high DOUBLE PRECISION DEFAULT 0.0 );
    SQL

    create_table :accounts do |t|
      t.integer     :portfolio_id
      t.integer     :starting_capital
    end
  end
end
