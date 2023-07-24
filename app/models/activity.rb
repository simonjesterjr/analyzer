# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :market
  has_many :market_moving_averages
  has_many :market_bollinger_bands
  has_many :market_highs

  scope :history, -> ( portfolio_id, market_id ) { where( market_id: market_id, portfolio_id: portfolio_id ) }
  # for use by technical-analysis gem
  def to_analysis_hash
    {
      date_time: date,
      open: open,
      high: high,
      low: low,
      close: close
    }
  end
end
