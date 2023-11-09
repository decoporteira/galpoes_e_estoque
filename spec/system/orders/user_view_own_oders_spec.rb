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

    it 'e não vê outros pedidos' do 
        #arrange
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        user_b = User.create!(name: 'Isabel', email: 'isabel@admin.com',password: 'password')
        user_c = User.create!(name: 'Bianca', email: 'bianca@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        warehouse_b = Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, description: "Uma galpão", address: "Av. Gigante, 400", cep: "39003-000")
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        supplier_b = Supplier.create!(corporate_name: 'Samsung SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '400', full_address: "Rua da Lapa, 300", state: "RJ", email: "contato@samsung.com.br")
       
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
        
        order_b = Order.create!(user: user_b, warehouse: warehouse_b, supplier: supplier_b, estimated_delivery_date: 5.day.from_now)
       
        order_c = Order.create!(user: user_c, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
     
        #act
        visit root_path
        login_as(user_a)
        click_on 'Meus Pedidos'
   
        #assert
        expect(page).to have_content order_a.code
        expect(page).not_to have_content order_b.code
        expect(page).not_to have_content order_c.code
 end
end