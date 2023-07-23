# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :market

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
