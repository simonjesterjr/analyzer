class DataToJson
  attr_reader :portfolio, :symbol
  attr_accessor :data

  def initialize( csi_portfolio, symbol )
    @portfolio = csi_portfolio
    @symbol = symbol
  end

  def call
    @data = file_to_array
  end

  def results
    data
  end

  def json_data
    data.to_json
  end

  def file_to_array
    results = []
    headers = []
    line_count = 0
    File.foreach( path ) do |line|
      line_count += 1
      headers = line.split(',').map(&:strip).map(&:underscore) if line_count == 1

      next if line_count == 1
      next if line.blank?

      arr = line.split(',').map(&:strip)
      next if arr.compact.empty?

      result = {}
      headers.each_with_index do |val,i |
        result[val.to_sym] = arr[i]
      end
      results << result
    end
    @data = results
  end

  def path
    "#{local_path}/#{portfolio}/#{symbol}.txt"
  end

  def local_path
    "/Users/johnkoisch/Library/Application Support/CrossOver/Bottles/sawtooth_trading/drive_c/UA/Data"
  end
end

