require 'rails_helper'

describe 'Usuário edita uma pedido' do 
    it 'não é o dono' do
        user_a = User.create!(name: 'André', email: 'andre@admin.com',password: 'password')
        user_b = User.create!(name: 'Isabel', email: 'isabel@admin.com',password: 'password')
        warehouse_a = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        warehouse_b = Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, description: "Uma galpão", address: "Av. Gigante, 400", cep: "39003-000")
        supplier_a = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        supplier_b = Supplier.create!(corporate_name: 'Samsung SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '400', full_address: "Rua da Lapa, 300", state: "RJ", email: "contato@samsung.com.br")
        order_a = Order.create!(user: user_a, warehouse: warehouse_a, supplier: supplier_a, estimated_delivery_date: 5.day.from_now)
        order_b = Order.create!(user: user_b, warehouse: warehouse_b, supplier: supplier_b, estimated_delivery_date: 5.day.from_now)
        
        
        login_as(user_a)
        patch(order_path(order_b.id), params: { order: {supplier_id: 3}})
        
        expect(response).to redirect_to(root_path)
    end
end
