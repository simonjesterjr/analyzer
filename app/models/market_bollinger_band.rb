# frozen_string_literal: true

class MarketBollingerBand < ApplicationRecord
  belongs_to :activity
  belongs_to :market
  belongs_to :portfolio
end
