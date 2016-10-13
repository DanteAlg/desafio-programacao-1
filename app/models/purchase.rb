class Purchase < ApplicationRecord
  def gross_revenue
    item_price * purchase_count
  end
end
