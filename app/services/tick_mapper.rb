class TickMapper
  def self.find( market, symbol = nil )
    if symbol.blank?
      market_map[market.to_sym]
    end
  end

  def self.market_map
    {
      nasdaq: { tick_value: 0.01, tick_size: 0.01 },
      nyse: { tick_value: 0.01, tick_size: 0.01 },
      sap: { tick_value: 0.01, tick_size: 0.01 }
    }
  end

end