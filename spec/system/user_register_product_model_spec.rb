require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
    it 'com sucesso' do
        # arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423434343423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        supplier_two = Supplier.create!(corporate_name: 'LG Corporate SA', brand_name: 'LG', city: 'São Paulo', registration_number: '34325456565', full_address: "Avenida das Coves, 343", state: "SP", email: "contato@lg.com.br")

        #act
        visit root_path
        click_on "Modelos de Produtos"
        click_on 'Cadastrar Novo'
        fill_in 'Nome', with: 'TV 32'
        fill_in 'Peso', with: 8000
        fill_in 'Largura', with: 45
        fill_in 'Profundidade', with: 50
        fill_in 'Altura', with: 20
        fill_in 'SKU', with: 'TV32-SAMSU-XPOTI23'
        select 'LG', from: 'Fornecedor'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content 'Modelo de produto cadastrado com sucesso.'
        expect(page).to have_content 'TV 32'
        expect(page).to have_content 'Fornecedor: LG'
        expect(page).to have_content 'SKU: TV32-SAMSU-XPOTI23'
        expect(page).to have_content 'Dimensão: 45cm x 50cm x 20cm'
        expect(page).to have_content 'Peso: 8000g'
    end
    it 'deve preencher todos os campos' do
        # arrange
        supplier = Supplier.create!(corporate_name: 'LG Corporate SA', brand_name: 'LG', city: 'Rio de Janeiro', registration_number: '32423434343423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")

        #act
        visit root_path
        click_on "Modelos de Produtos"
        click_on 'Cadastrar Novo'
        fill_in 'Nome', with: ''
        fill_in 'Peso', with: 8000
        fill_in 'Largura', with: 45
        fill_in 'Profundidade', with: 50
        fill_in 'Altura', with: 20
        fill_in 'SKU', with: '5435435'
        select 'LG', from: 'Fornecedor'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content 'Não foi possível cadastrar o modelo de produto.'

    end
end