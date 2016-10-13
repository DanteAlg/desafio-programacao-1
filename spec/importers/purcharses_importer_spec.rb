require 'rails_helper'

RSpec.describe PurchasesImporter do
  it 'headers orderned' do
    expect(described_class::HEADER).to eq(
      [
        'purchaser_name',
        'item_description',
        'item_price',
        'purchase_count',
        'merchant_address',
        'merchant_name'
      ]
    )
  end

  describe '#run' do
    let(:file) { file_fixture 'example_input.tab' }
    subject(:do_import) { described_class.new(file).run }

    it 'create purcharses' do
      expect{ do_import }.to change(Purchase, :count).by(4)
    end
  end
end
