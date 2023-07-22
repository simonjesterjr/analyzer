class Market < ApplicationRecord
  has_and_belongs_to_many :portfolios
  has_many :activities

  attr_accessor :max_open, :min_open, :max_close, :min_close,
                :max, :min, :volume, :vix

  enum period: [ :day, :week, :hour, :tick ]

  def risk( account_value, percentage: 0.02, atr_multiplier: 2 )
    {
      account_value: account_value,
      risk_dollars: percentage * account_value,
      current_atr: activities&.last&.atr || 2,
      current_tick_atr: 0,
      atr_tick_stop: atr_multiplier * 0,
      current_atr_dollars: 0.00,
      atr_dollar_risk: 0.00,
      contracts: 3.24,
      units: 3.24.floor
    }
  end

end
