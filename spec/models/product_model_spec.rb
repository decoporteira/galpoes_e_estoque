require 'rails_helper'

RSpec.describe ProductModel, type: :model do
    describe '#valid?' do
        it 'name is mandatory' do
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423434343423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
            pm = ProductModel.new(name: '',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
        result = pm.valid?
        
        expect(result).to eq false

        end

        it 'SKU is mandatory' do
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423434343423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
            pm = ProductModel.new(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: '', supplier: supplier)
        result = pm.valid?
        
        expect(result).to eq false

        end
    end

end
