require 'rails_helper'
describe 'Usuário informa novo statu de pedido' do
    it 'e pedido foi entregue' do 
        #arrange
        user = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.day.from_now, status: 'pending')
        product_a = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
 
        OrderItem.create!(product_model: product_a, order: order, quantity: 19)

        #act
        visit root_path
        login_as(user)
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Marcar como entregue'

        #assert
        expect(current_path).to eq order_path(order.id)   
        expect(page).to have_content 'Status: Entregue'
        expect(page).to have_content 'Pedido atualizado com sucesso.'
        expect(page).not_to have_button 'Marcar como entregue'
        expect(StockProduct.count).to eq 19
        estoque = StockProduct.where(product_model: product_a, warehouse: warehouse).count
        expect(estoque).to eq 19
    end

    it 'e pedido foi cancelado' do 
        #arrange
        user = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.day.from_now, status: 'pending')
        product_a = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
 
        OrderItem.create!(product_model: product_a, order: order, quantity: 19)

        #act
        visit root_path
        login_as(user)
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Marcar como cancelado'

        #assert
        expect(current_path).to eq order_path(order.id)   
        expect(page).to have_content 'Status: Cancelado'
        expect(page).to have_content 'Pedido atualizado com sucesso.'
        expect(page).not_to have_button 'Marcar como cancelado'
        expect(StockProduct.count).to eq 0
     
    end

end