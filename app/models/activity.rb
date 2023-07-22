# frozen_string_literal: true

class Activity < ApplicationRecord
  belongs_to :market

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
