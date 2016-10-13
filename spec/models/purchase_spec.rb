require 'rails_helper'

RSpec.describe Purchase do
  describe '#gross_revenue' do
    let(:purchase) { build(:purchase, item_price: 20.0, purchase_count: 3) }

    it { expect(purchase.gross_revenue).to eq(60.0) }
  end
end
