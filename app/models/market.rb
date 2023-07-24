class Market < ApplicationRecord
  has_and_belongs_to_many :portfolios
  has_many :activities
  has_many :market_moving_averages
  has_many :market_bollinger_bands
  has_many :market_highs

  enum period: [ :day, :week, :hour, :tick ]

  after_find :tick_update

  def risk( account_value: nil, percentage: 0.02, atr_multiplier: 2 )
    raise StandardError.new( "No Activities loaded" ) if activities.size.zero?

    unless account_value
      account_value = portfolio.account.starting_capital/100
    end

    normalized_tick = ( 1 / tick_size ) * tick_value
    atr_val = activities&.order( date: :asc ).last&.atr || 0
    tick_multiple = atr_multiplier * atr_val * normalized_tick
    result = {
      account_value: account_value,
      risk_dollars: percentage * account_value,
      current_atr:  float_of_2_decimal( atr_val ),
      atr_tick_stop: float_of_2_decimal( atr_multiplier * atr_val ),
      current_atr_dollars: float_of_2_decimal( atr_val * normalized_tick ),
      atr_dollar_risk: float_of_2_decimal( tick_multiple )
    }
    if tick_multiple > 0
      result.merge!( contracts: float_of_2_decimal( ( percentage * account_value ) / tick_multiple ),
                     units: ( ( percentage * account_value) / tick_multiple ).floor )
    end
    result
  end

  def tick_update
    return if tick_size.present? && tick_value.present?

    result = TickMapper.find( trading_market.to_sym, nil )
    self.tick_value = result[:tick_value]
    self.tick_size = result[:tick_size]
    save!
  end
end
