# frozen_string_literal: true

class MarketHigh < ApplicationRecord
  belongs_to :activity
  belongs_to :market
  belongs_to :portfolio
end
