# frozen_string_literal: true

module Signalable

  def determine_signal( act, signal )
    if act.trading_signals.empty? || act.trading_signals.detect{ |ts| ts.triggers == signal[:signal] }
      # {
      #   calling_id: id,
      #   signal: signal,
      #   direction: direction.to_s,
      #   notes: notes.blank? ? "" : notes
      # }
      return create_signal( signal[:signal],
                            signal[:direction],
                            act,
                            notes: signal[:notes] )
    end
    nil
  end

  def create_signal( originator, direction, activity, notes: "" )
    action = direction == :long ? 'buy' : 'sell'
    risk = activity.risk( activity.portfolio.account.starting_capital)
    description = <<~MESSAGE
      #{action} #{activity.market.trading_symbol} on #{activity.market.trading_market.upcase}
      at #{activity.close}
      NOTES: #{notes}
    MESSAGE
    {
      action_description: description,
      triggers: originator.to_s,
      direction: TradingSignal.directions[direction],
      activity_id: activity.id
    }
  end

  def alert

  end
end
