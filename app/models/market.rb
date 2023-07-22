class Market < ApplicationRecord
  has_and_belongs_to_many :portfolios
  has_many :activities

  enum period: [ :day, :week, :hour, :tick ]

  after_find :tick_update

  def risk( account_value, percentage: 0.02, atr_multiplier: 2 )
    normalized_tick = ( 1 / tick_size ) * tick_value
    atr_val = activities&.order( date: :asc ).last&.atr || 0
    {
      account_value: account_value,
      risk_dollars: percentage * account_value,
      current_atr:  atr_val,
      atr_tick_stop: atr_multiplier * atr_val,
      current_atr_dollars: atr_val * normalized_tick,
      atr_dollar_risk: atr_multiplier * atr_val * normalized_tick,
      contracts: (atr_multiplier * atr_val * normalized_tick) / (percentage * account_value),
      units: ((atr_multiplier * atr_val * normalized_tick) / (percentage * account_value)).floor
    }
  end

  def tick_update
    return if tick_size.present? && tick_value.present?

    result = TickMapper.find( trading_market.to_sym, nil )
    self.tick_value = result[:tick_value]
    self.tick_size = result[:tick_size]
    save!
  end
end
