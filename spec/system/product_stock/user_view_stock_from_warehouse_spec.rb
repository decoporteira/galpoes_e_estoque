require 'rails_helper'

describe 'Usuário vê o esoque' do
    it 'na tela do galpão' do
        user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
        product_a = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
        product_b = ProductModel.create!(name: 'TV 42',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV42-SAMSU-XPOTI23', supplier: supplier)
        product_c = ProductModel.create!(name: 'TV 55',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV55-SAMSU-XPOTI23', supplier: supplier)
        
        3.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a) }
        2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b) }

        visit root_path
        login_as(user)
        click_on 'Aeroporto SP'
        within('section#stock_products') do
            expect(page).to have_content('Itens em Estoque:') 
            expect(page).to have_content('3 x TV 32') 
            expect(page).to have_content('2 x TV 42') 
            expect(page).not_to have_content('TV 55') 
        end
    end
    it 'e dá baixa em um item' do
        user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br") 
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 10.days.from_now)
        product_a = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
        product_b = ProductModel.create!(name: 'TV 42',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV42-SAMSU-XPOTI23', supplier: supplier)
        product_c = ProductModel.create!(name: 'TV 55',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV55-SAMSU-XPOTI23', supplier: supplier)
        
        3.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_a) }
        2.times {StockProduct.create!(order: order, warehouse: warehouse, product_model: product_b) }

        visit root_path
        login_as(user)
        click_on 'Aeroporto SP'
        select 'TV 32', from: 'Item para Saída'
        fill_in 'Destinatário', with: 'André Pereira'
        fill_in 'Endereço Destino', with: 'Rua das Palmeiras, 34, São Paulo - SP'
        click_on 'Confirmar retirada'

        expect(current_path).to eq warehouse_path(warehouse.id)
        expect(page).to have_content('Item retirado com sucesso') 
        expect(page).to have_content('2 x TV 32') 
        expect(page).to have_content('2 x TV 42') 
        #expect(page).to have_content('Destinatário: André Pereira') 
        #expect(page).to have_content('Endereço Destino: Rua das Palmeiras, 34, São Paulo - SP') 
        
    end
end