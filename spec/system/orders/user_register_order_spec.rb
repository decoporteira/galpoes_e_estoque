require 'rails_helper'

describe 'Usuário cadastra um pedido' do
    it 'e deve esta autenticado' do 
        visit root_path
        click_on 'Registrar pedido'

        expect(current_path).to eq new_user_session_path
    end
    
    
    it 'com sucesso' do
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
        login_as(user)
        click_on 'Registrar pedido'
        select 'GRU | Aeroporto SP', from: 'Galpão Destino'
        select supplier.corporate_name, from: 'Fornecedor'
        fill_in 'Data prevista', with: '20/12/2030'
        click_on 'Gravar'

        #assert
        expect(page).to have_content 'Pedido registrado com sucesso'
        expect(page).to have_content 'Galpão Destino: GRU | Aeroporto SP'
        expect(page).to have_content 'Pedido: 12345678'
        expect(page).to have_content 'Fornecedor: Samsung Corporate SA'
        expect(page).to have_content 'Usuário responsável: Admin - admin@admin.com'
        expect(page).to have_content 'Data prevista para entrega: 20/12/2030' 
        expect(page).not_to have_content 'Cuiaba'
        expect(page).not_to have_content 'Xiaomi Corporate SA'
    end
    it 'com fracasso pois a data já passou' do
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
         
        #act
        visit root_path
        login_as(user)
        click_on 'Registrar pedido'
        select 'GRU | Aeroporto SP', from: 'Galpão Destino'
        select supplier.corporate_name, from: 'Fornecedor'
        fill_in 'Data prevista', with: '20/12/2020'
        click_on 'Gravar'

        #assert
        
        expect(page).to have_content('Não foi possível cadastrar pedido.')
    end

end