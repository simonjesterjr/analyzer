class PeriodData
  include Modis::Model

  attribute :market_id, :integer

  attribute :open, :integer
  attribute :high, :integer
  attribute :low, :integer
  attribute :close, :integer
  attribute :volume, :integer
  attribute :timestamp, :string

  attribute :period, :integer

  index :market_id
end
