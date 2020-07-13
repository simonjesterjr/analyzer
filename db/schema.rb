# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_11_203450) do

  create_table "markets", force: :cascade do |t|
    t.string "name", null: false
    t.string "trading_symbol", null: false
    t.integer "period", default: 0
    t.string "trading_market", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "markets_portfolios", id: false, force: :cascade do |t|
    t.integer "portfolio_id"
    t.integer "market_id"
    t.index ["market_id"], name: "index_markets_portfolios_on_market_id"
    t.index ["portfolio_id"], name: "index_markets_portfolios_on_portfolio_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "portfolios_rules", id: false, force: :cascade do |t|
    t.integer "portfolio_id"
    t.integer "rule_id"
    t.index ["portfolio_id"], name: "index_portfolios_rules_on_portfolio_id"
    t.index ["rule_id"], name: "index_portfolios_rules_on_rule_id"
  end

  create_table "rules", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "category"
    t.text "components"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "signals", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "rule_id"
    t.integer "portfolio_id"
    t.string "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
