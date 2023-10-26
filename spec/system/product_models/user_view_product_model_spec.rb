require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
    it 'se estive autenticado' do 
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end

        # Assert
        expect(current_path).to eq new_user_session_path
    end

    it 'a partir do menu' do
        #arrange
        user = User.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')

        #Act]
        login_as(user, :scope => :user)
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end

        #assert
        expect(current_path).to eq product_models_path

    end

    it 'com sucesso' do
        #arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423434343423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        ProductModel.create!(name: 'TV 32',weight: 8000, width: 70, height: 89, depth: 45, sku: 'TV32-SAMSU-XPOTI23', supplier: supplier)
        ProductModel.create!(name: 'TV 42',weight: 9000, height: 89, width: 80,depth: 55, sku: 'TV42-SAMSU-X55555', supplier: supplier)
        user = User.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')

        #Act]
        login_as(user)
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end

        #assert
        expect(page).to have_content 'TV 32'
        expect(page).to have_content 'TV32-SAMSU-XPOTI23'
        expect(page).to have_content 'Samsung'
        expect(page).to have_content 'TV 42'
        expect(page).to have_content 'TV42-SAMSU-X55555'
    end

    it 'e não existem produtos cadastrados' do
        user = User.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')

        #Act]
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'

        expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
    end
end