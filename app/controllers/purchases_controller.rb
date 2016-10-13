class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all
    @gross_revenues = @purchases.map(&:gross_revenue).sum
  end

  def create
    PurchasesImporter.new(upload_param[:file].tempfile).run
    redirect_to purchases_path
  end

  private

  def upload_param
    params.require(:purchases).permit(:file)
  end
end
