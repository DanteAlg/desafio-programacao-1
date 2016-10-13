class PurchasesController < ApplicationController
  def index
    @purchases = Purchase.all
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
