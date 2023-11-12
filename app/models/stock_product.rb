class StockProduct < ApplicationRecord
  belongs_to :warehouse
  belongs_to :order
  belongs_to :product_model
  has_one :stock_product_destination

  before_validation :generate_code, on: :create

  def available?
   if stock_product_destination.nil?
    return true
   else
    return false
   end
  end

  private

  def generate_code
    self.serial_number = SecureRandom.alphanumeric(20).upcase
  end
end


