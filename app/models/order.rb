class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  validates :code, :estimated_delivery_date, presence: true
  validate :check_date
  before_validation :generate_code


  private 

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def check_date
    if self.estimated_delivery_date.present? && self.estimated_delivery_date <= Date.today
    self.errors.add(:estimated_delivery_date, " Deve ser superior a hoje.")
    
    end

  end
end
