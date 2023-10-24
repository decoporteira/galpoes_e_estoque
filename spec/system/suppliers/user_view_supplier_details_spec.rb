require 'rails_helper'

describe 'usuário acessa a página de detalhes do fornecedor' do
    it 'acessa a tela com sucesso' do
        f = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        visit(suppliers_path)
        click_on('Samsung Corporate SA')

        expect(page).to have_content('Samsung Corporate SA')
        expect(page).to have_content('Samsung')
        expect(page).to have_content('Rio de Janeiro')
        expect(page).to have_content('32423423')
        expect(page).to have_content('Rua das Casas, 180')
        expect(page).to have_content('RJ')
        expect(page).to have_content('contato@samsung.com.br')
    end
    it 'e volta para a listagem de fornecedores' do
        f = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")

        visit(suppliers_path)
        click_on('Samsung Corporate SA') 
        click_on('Voltar')
    # Assert
       expect(current_path).to eq(suppliers_path)
    end
end