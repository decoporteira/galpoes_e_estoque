require 'rails_helper'

describe 'Usuário busca por um pedido' do
    it 'a partir do menu' do
        user = User.create!(name: 'Joao', email: 'admin@admin.com', password: 'password')
        
        login_as(user)
        
        visit root_path
        within('header nav') do
            expect(page).to have_field('Buscar pedido')
            expect(page).to have_content('Buscar')
        end
    end
    it 'e deve estar autenticada' do
        
        visit root_path

        within('header nav') do
            expect(page).not_to have_field('Buscar pedido')
            expect(page).not_to have_content('Buscar')
        end

    end

    it 'e encontra um pedido' do
        user = User.create!(name: 'Admin', email: 'admin@admin.com',password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
        supplier = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 5.day.from_now)

        login_as(user)
        visit root_path
        fill_in 'Buscar pedido', with: order.code
        click_on 'Buscar'

        expect(page).to have_content "Resultados da buscar por: #{order.code}"
        expect(page).to have_content '1 pedido encontrado'
        expect(page).to have_content "Código: #{order.code}"
        expect(page).to have_content "Galpão Destino: Aeroporto SP"
        expect(page).to have_content "Fornecedor: Xiaomi"

    end
end
