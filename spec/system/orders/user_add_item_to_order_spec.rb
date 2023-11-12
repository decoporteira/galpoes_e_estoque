require 'rails_helper'

describe 'Usuário adicioNA itens ao pedido ' do 
    it 'com sucesso' do
        user = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        product_a = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
        product_b = ProductModel.create!(name: 'TV 42',weight: 9000, height: 89, width: 80,depth: 55, sku: 'TV42-SAMSU-X55555', supplier: supplier)
       

        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.day.from_now)
        OrderItem.create!(product_model: product_a, order: order, quantity: 19)
        OrderItem.create!(product_model: product_b, order: order, quantity: 12)

        visit root_path
        login_as(user)
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'
        select 'TV 32', from: 'Produto'
        fill_in 'Quantidade', with: '8'
        click_on 'Gravar'

       expect(current_path).to eq order_path(order.id)
       expect(page).to have_content 'Item adicionado com sucesso.'
       expect(page).to have_content '8 x TV 32'
    end

    it 'e não vê produtos de outro fornecedor' do
        user = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "SP", email: "xiaomi@xiaomi.com.br")
        supplier_b = Supplier.create!(corporate_name: 'Samsung LTDA', brand_name: 'Xiaomi', city: 'Rio de Janeiro', registration_number: '556678', full_address: "Rua da Tecnologia", state: "RJ", email: "samsung@samsung.com.br")

        product_a = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier_a)
        product_b = ProductModel.create!(name: 'TV 42',weight: 9000, height: 89, width: 80,depth: 55, sku: 'TV42-SAMSU-X55555', supplier: supplier_a)
        product_c = ProductModel.create!(name: 'Celular A5',weight: 500, height: 309, width: 30,depth: 15, sku: 'CLR-A5-3423432', supplier: supplier_b)

        order = Order.create!(user: user, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
        OrderItem.create!(product_model: product_a, order: order, quantity: 19)
        OrderItem.create!(product_model: product_b, order: order, quantity: 12)

        visit root_path
        login_as(user)
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'
      
       expect(page).to have_content 'TV 32'
       expect(page).not_to have_content 'Celular A5'
    end

end