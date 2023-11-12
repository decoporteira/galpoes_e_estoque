require 'rails_helper'

describe 'Usuário se seus próprios pedidos' do 
    it 'e deve estar autenticado' do
        #arrange
        user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                        address: 'Avenida do Contorno, 20', cep: '20000-000',
                                        description: 'Galpão destinado para cargas internacionais')
        Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10000, cep: '50000-000', city: 'Cuiaba', description: 'Galpão no centro do país', address: 'Av da Torre, 301')                                
        supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', 
                                        city: 'Rio de Janeiro', registration_number: '200', 
                                        full_address: "Rua das Casas, 180", state: "SP", 
                                        email: "contato@samsung.com.br")                               
        Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
         
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        #act
        visit root_path
        click_on 'Meus Pedidos'
      

        #assert
        expect(current_path).to eq new_user_session_path
    end

    it 'e vê seus pedidos' do 
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        user_b = User.create!(name: 'Isabel', email: 'isabel@admin.com',password: 'password')
        user_c = User.create!(name: 'Bianca', email: 'bianca@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        warehouse_b = Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, description: "Uma galpão", address: "Av. Gigante, 400", cep: "39003-000")
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        supplier_b = Supplier.create!(corporate_name: 'Samsung SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '400', full_address: "Rua da Lapa, 300", state: "RJ", email: "contato@samsung.com.br")
       
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now, status: 'pending')
        
        order_b = Order.create!(user: user_b, warehouse: warehouse_b, supplier: supplier_b, estimated_delivery_date: 5.day.from_now, status: 'delivered')
       
        order_c = Order.create!(user: user_c, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now, status: 'canceled')
     
        #act
        visit root_path
        login_as(user_a)
        click_on 'Meus Pedidos'
   
        #assert
        expect(page).to have_content order_a.code
        expect(page).not_to have_content order_b.code
        expect(page).not_to have_content order_c.code
        expect(page).to have_content 'Pendente'
        expect(page).not_to have_content 'Cancelado'

 end

    it 'e ve a tela de entrada' do 
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
        visit root_path
        login_as(user_a)
        click_on 'Meus Pedidos'
        click_on order_a.code

        #assert
        expect(page).to have_content 'Detalhes do pedido'
        expect(page).to have_content order_a.code
        expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
        formatted_date = I18n.localize(5.days.from_now.to_date)
        expect(page).to have_content "Data prevista para entrega: #{formatted_date}"
    end

    it 'e não vê outros pedidos' do 
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
        visit root_path
        login_as(user_a)
        visit order_path(order_b)

        #assert
        expect(current_path).not_to eq order_path(order_a)
        expect(current_path).to eq root_path
        expect(page).to have_content 'Você não possui acesso a esse pedido.'
    
    end

    it 'e ve itens do pedido' do 
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        product_a = ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier_a)
        product_b = ProductModel.create!(name: 'TV 42',weight: 9000, height: 89, width: 80,depth: 55, sku: 'TV42-SAMSU-X55555', supplier: supplier_a)
        product_c = ProductModel.create!(name: 'Celular A5',weight: 500, height: 309, width: 30,depth: 15, sku: 'CLR-A5-3423432', supplier: supplier_a)

        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
        OrderItem.create!(product_model: product_a, order: order_a, quantity: 19)
        OrderItem.create!(product_model: product_b, order: order_a, quantity: 12)

        #act
        visit root_path
        login_as(user_a)
        click_on 'Meus Pedidos'
        click_on order_a.code

        #assert
        expect(page).to have_content 'Itens do pedido:'
        expect(page).to have_content '19 x TV 32'
        expect(page).not_to have_content 'Celular A5'

       
    
    end

end