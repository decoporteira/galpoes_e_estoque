class Supplier < ApplicationRecord
    validates :corporate_name, :brand_name, :city, :full_address, :registration_number, :state, :email, presence: true
    validates :registration_number, uniqueness: true

end
