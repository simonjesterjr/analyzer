# frozen_string_literal: true

class MarketMovingAverage < ApplicationRecord
  belongs_to :market
  belongs_to :portfolio
  belongs_to :activity

end
