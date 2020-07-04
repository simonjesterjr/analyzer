class DataChunk
  include Modis::Model
  attribute :open, :integer
  attribute :high, :integer
  attribute :low, :integer
  attribute :close, :integer
  attribute :volume, :integer
  attribute :timestamp, :integer

  attribute :period, :integer
end
