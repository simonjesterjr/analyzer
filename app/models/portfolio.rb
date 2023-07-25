class Portfolio < ApplicationRecord
    has_and_belongs_to_many :markets
    has_and_belongs_to_many :rules
    has_many :activities
    has_many :markets
    has_many :accounts
    has_many :trading_signals, through: :activities, class_name: 'TradingSignal'
end
