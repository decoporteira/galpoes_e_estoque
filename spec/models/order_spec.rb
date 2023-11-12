require 'rails_helper'

RSpec.describe Order, type: :model do
    describe '#valid?' do
        it 'deve ter um código' do
                user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
                warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                                address: 'Avenida do Contorno, 20', cep: '20000-000',
                                                description: 'Galpão destinado para cargas internacionais')
                supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
                order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.day.from_now)
                
                result = order.valid?

                expect(result).to be true
        
        end
        it 'dada de entrega tem que ser preenchida' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                            address: 'Avenida do Contorno, 20', cep: '20000-000',
                                            description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '')
            
            order.valid?


            expect(order.errors.include? :estimated_delivery_date).to be true
    
        end
        it 'data estimada não pode ter passado' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                            address: 'Avenida do Contorno, 20', cep: '20000-000',
                                            description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.ago)
            
            result = order.valid?


            expect(order.errors.include? :estimated_delivery_date).to be true
            expect(order.errors[:estimated_delivery_date]).to include(' Deve ser superior a hoje.')
        end
        it 'data estimada não pode ser hoje' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                            address: 'Avenida do Contorno, 20', cep: '20000-000',
                                            description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: Date.today)
            
            result = order.valid?


            expect(order.errors.include? :estimated_delivery_date).to be true
            expect(order.errors[:estimated_delivery_date]).to include(' Deve ser superior a hoje.')
        end
        it 'data estimada deve ser maior ou igual a amanhã' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                            address: 'Avenida do Contorno, 20', cep: '20000-000',
                                            description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
            
            result = order.valid?


            expect(order.errors.include? :estimated_delivery_date).to be false

        end
    end
    describe 'gera um código aleatorio' do
        it 'ao criar um novo pedido' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                            address: 'Avenida do Contorno, 20', cep: '20000-000',
                                            description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.days.from_now)
            
            order.save!
            result = order.code

            expect(result).not_to be_empty
            expect(result.length).to eq 8
        end

        it 'e o código é único' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                            address: 'Avenida do Contorno, 20', cep: '20000-000',
                                            description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
            second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.days.from_now)

            second_order.save!

            expect(second_order.code).not_to eq first_order.code
            
        end
        it 'e não deve ser modificado' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
            original_code = order.code                                 
            
            order.update!(estimated_delivery_date: 1.month.from_now)
            
            expect(order.code).to eq(original_code)
        
        end
    end

end
