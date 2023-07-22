class GetDataFromCsi
  attr_reader :symbol, :portfolio

  def initialize( portfolio, symbol )
    @portfolio = portfolio
    @symbol = symbol

  end
  def call
    File.foreach( path ) do |line|
      yield line
    end
  end

  def path
    "#{local_path}/#{portfolio}/#{symbol}.txt"
  end

  def local_path
    "/Users/johnkoisch/Library/Application Support/CrossOver/Bottles/sawtooth_trading/drive_c/UA/Data"
  end
end