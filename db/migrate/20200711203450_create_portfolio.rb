class CreatePortfolio < ActiveRecord::Migration[6.0]
  def change
    create_table :portfolios do |t|
      t.string          :name
      t.string          :description

      t.timestamps
    end

    create_table :rules do |t|
      t.string        :name
      t.string        :description
      t.integer       :category
      t.text          :components

      t.timestamps
    end

    create_table :signals do |t|
      t.integer         :status, default: 0
      t.integer         :rule_id
      t.integer         :portfolio_id
      t.string          :note

      t.timestamps
    end

    create_table :portfolios_rules, id: false do |t|
      t.belongs_to :portfolio
      t.belongs_to :rule
    end

    create_table :markets_portfolios, id: false do |t|
      t.belongs_to :portfolio
      t.belongs_to :market
    end
  end
end
