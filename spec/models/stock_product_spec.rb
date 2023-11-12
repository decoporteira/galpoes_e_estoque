require 'rails_helper'

RSpec.describe StockProduct, type: :model do
    describe 'gera um número de série' do
    
        it 'ao criar um produto em estoque' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
            product = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
           
            stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
            
            expect(stock_product.serial_number.length).to eq 20
        end

        it 'e não é modificado' do
            user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
            warehouse_b = Warehouse.create!(name: 'Aeroporto RJ', code: 'RIO', city: 'Rio de Janeiro', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
            supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
            order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
            product = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
            stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
            original_serial_number = stock_product.serial_number

            stock_product.update!(warehouse: warehouse_b)

            expect(stock_product.serial_number).to eq original_serial_number
        
        end
        describe '#available?' do
            it 'true se não tiver destino' do
                user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
                warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
                warehouse_b = Warehouse.create!(name: 'Aeroporto RJ', code: 'RIO', city: 'Rio de Janeiro', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
                supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
                order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
                product = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
                
                stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
            
                expect(stock_product.available?).to eq true
            
            end
            it 'false se tiver destino' do
                user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
                warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
                warehouse_b = Warehouse.create!(name: 'Aeroporto RJ', code: 'RIO', city: 'Rio de Janeiro', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
                supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
                order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
                product = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
                
                stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
                stock_product.create_stock_product_destination!(recipient: 'João', address: 'Rua das coves, 34')

                expect(stock_product.available?).to eq false
            
            end
        end

    end
end
