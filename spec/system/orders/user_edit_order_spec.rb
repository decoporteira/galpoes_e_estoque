require 'rails_helper'

describe 'Usuário edita pedido' do 
    it 'e deve estar autenticado' do
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
        
        #act
        visit edit_order_path(order_a)
        click_on 'Meus Pedidos'
      
        #assert
        expect(current_path).to eq new_user_session_path
    end

    it 'com sucesso' do
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        user_b = User.create!(name: 'Isabel', email: 'isabel@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        warehouse_b = Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, description: "Uma galpão", address: "Av. Gigante, 400", cep: "39003-000")
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        supplier_b = Supplier.create!(corporate_name: 'Samsung SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '400', full_address: "Rua da Lapa, 300", state: "RJ", email: "contato@samsung.com.br")
    
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
        
        
        #act
        visit root_path
        login_as(user_a)
        click_on 'Meus Pedidos'
        click_on order_a.code
        click_on 'Editar'
        fill_in 'Data prevista para entrega', with: 10.day.from_now
        select 'Samsung SA', from: 'Fornecedor'
        click_on 'Salvar'
          #assert
        expect(page).to have_content 'Detalhes do pedido'
        expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
        expect(page).to have_content 'Fornecedor: Samsung SA'
        formatted_date = I18n.localize(10.days.from_now.to_date)
        expect(page).to have_content "Data prevista para entrega: #{formatted_date}"
    end

    it 'caso seja o responsavel' do
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        user_b = User.create!(name: 'Isabel', email: 'isabel@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        warehouse_b = Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, description: "Uma galpão", address: "Av. Gigante, 400", cep: "39003-000")
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        supplier_b = Supplier.create!(corporate_name: 'Samsung SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '400', full_address: "Rua da Lapa, 300", state: "RJ", email: "contato@samsung.com.br")
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
        order_b = Order.create!(user: user_b, warehouse: warehouse_b, supplier: supplier_b, estimated_delivery_date: 5.day.from_now)
        
        #act
        login_as(user_a)
        visit edit_order_path(order_b)
  
        #assert
        expect(current_path).to eq root_path
    end

end