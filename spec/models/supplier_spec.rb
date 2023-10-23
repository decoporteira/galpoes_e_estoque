require 'rails_helper'

RSpec.describe Supplier, type: :model do
    describe 'é válido' do
        context 'presence' do 
            it 'retornar falso quando o Corporate name é vazio' do
                supplier = Supplier.new(corporate_name: '', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br")
            
                result = supplier.valid?

                expect(result).to eq false
            end
            it 'retorna falso quando a brand name é vazio' do
                supplier = Supplier.new(corporate_name: 'Samsung Corporate SA', brand_name: '',registration_number: '200', city: 'Rio de Janeiro', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br")
            
                result = supplier.valid?

                expect(result).to eq false
            end
            it 'retorna falso quando registration number é vazio' do
                supplier = Supplier.new(corporate_name: 'Samsung Corporate SA', brand_name: '',registration_number: '', city: 'Rio de Janeiro', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br")
            
                result = supplier.valid?

                expect(result).to eq false
            end

        end
        context 'numero de registro' do
            it 'é falso quando o numero de registro já está cadastrado' do
                supplier_one = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br")
                supplier_two = Supplier.new(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '200', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
                result = supplier_two.valid?

                expect(result).to eq false
            end
        end  
    end
end
