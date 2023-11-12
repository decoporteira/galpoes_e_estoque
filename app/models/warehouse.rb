class Warehouse < ApplicationRecord
    validates :name, :code, :city, :description, :address, :cep, :area, presence: true
    validates :code, length: {is: 3}
    validates :code, uniqueness: true
    has_many :stock_products

    def full_description
        "#{code} | #{name}"
    end
end
