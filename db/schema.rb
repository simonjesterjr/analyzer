# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_22_214935) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "timescaledb"
  enable_extension "timescaledb_toolkit"

  create_table "activities", force: :cascade do |t|
    t.integer "market_id"
    t.date "date"
    t.float "open"
    t.float "high"
    t.float "low"
    t.float "close"
    t.integer "volume"
    t.integer "oi"
    t.integer "numeric_delivery_month"
    t.float "atr", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "markets", force: :cascade do |t|
    t.string "name", null: false
    t.string "trading_symbol", null: false
    t.integer "period", default: 0
    t.string "trading_market", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "tick_size"
    t.float "tick_value"
  end

  create_table "markets_portfolios", id: false, force: :cascade do |t|
    t.bigint "portfolio_id"
    t.bigint "market_id"
    t.index ["market_id"], name: "index_markets_portfolios_on_market_id"
    t.index ["portfolio_id"], name: "index_markets_portfolios_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "csi_portfolio"
  end

  create_table "portfolios_rules", id: false, force: :cascade do |t|
    t.bigint "portfolio_id"
    t.bigint "rule_id"
    t.index ["portfolio_id"], name: "index_portfolios_rules_on_portfolio_id"
    t.index ["rule_id"], name: "index_portfolios_rules_on_rule_id"
  end

  create_table "positions", force: :cascade do |t|
    t.integer "portfolio_id"
    t.integer "units"
    t.float "execution_price"
    t.float "order_price"
    t.string "action_description"
    t.float "original_stop"
    t.float "updated_stop"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rules", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "category"
    t.text "components"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signals", force: :cascade do |t|
    t.integer "units"
    t.string "action_description"
    t.string "triggers"
    t.boolean "test"
    t.integer "direction"
    t.float "stop"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
