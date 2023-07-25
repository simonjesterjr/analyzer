class TradingSignal < ApplicationRecord
  belongs_to :activity

  enum direction: [ :long, :short ]

  def portfolio
    activity.portfolio
  end


end
