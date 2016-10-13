class PurchasesImporter
  HEADER = ['purchaser_name', 'item_description', 'item_price', 'purchase_count', 'merchant_address', 'merchant_name']
  attr_reader :file_content

  def initialize(file)
    @file_content = file.read
  end

  def run
    @file_content.lines.drop(1).each do |line|
      values = HEADER.zip(line.chomp.split(/\t/)).to_h
      Purchase.create!(values.merge(file_id: 'file_token'))
    end
  end
end
