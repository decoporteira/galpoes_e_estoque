require 'rails_helper'
describe 'Usuário informa novo statu de pedido' do
    it 'e pedido foi entregue' do 
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now, status: 'pending')
        
        #act
        visit root_path
        login_as(user_a)
        click_on 'Meus Pedidos'
        click_on order_a.code
        click_on 'Marcar como entregue'

        #assert
        expect(current_path).to eq order_path(order_a.id)   
        expect(page).to have_content 'Status: Entregue'
        expect(page).to have_content 'Pedido atualizado com sucesso.'
        expect(page).not_to have_button 'Marcar como entregue'

    end
    it 'e pedido foi cancelado' do 
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now, status: 'pending')
        
        #act
        visit root_path
        login_as(user_a)
        click_on 'Meus Pedidos'
        click_on order_a.code
        click_on 'Marcar como cancelado'

        #assert
        expect(current_path).to eq order_path(order_a.id)   
        expect(page).to have_content 'Status: Cancelado'
        expect(page).to have_content 'Pedido atualizado com sucesso.'
        expect(page).not_to have_button 'Marcar como cancelado'


    end

end