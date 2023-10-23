require 'rails_helper'

describe 'Usuario visite tela inicial de Suppliers' do
    it 'e vê o nome do app' do
        visit(root_path)
        click_on('Fornecedores')
        expect(page).to have_content('Fornecedores')
    end

    it 'e ve os fornecedores cadastrados' do
        # Arrange
        Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '200', full_address: "Rua das Casas, 180", state: "SP", email: "contato@samsung.com.br")
        Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        # Act
        visit(suppliers_path)

        # Assert
        expect(page).not_to have_content('Não existem fornecedores cadastrados.')
        expect(page).to have_content('Samsung Corporate SA')
        expect(page).to have_content('Brand Name: Samsung')
        expect(page).to have_content('City: Rio de Janeiro')
        expect(page).to have_content('Registration Number: 200')

        expect(page).to have_content('Xiaomi Corporate SA')
        expect(page).to have_content('Brand Name: Xiaomi')
        expect(page).to have_content('City: São Paulo')
        expect(page).to have_content('Registration Number: 300')

    end

    it 'e não ve fornecedores cadastrados' do
        visit(suppliers_path)
        expect(page).to have_content('Não existem fornecedores cadastrados.')
    end
end