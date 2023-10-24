require 'rails_helper'

describe 'Usuário editar um galpão' do
    it 'a partir da página de detalhes' do
        f = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        
        visit(suppliers_path)
        click_on('Samsung Corporate SA')
        click_on('Editar')

        expect(page).to have_content('Editar Fornecedor')
        expect(page).to have_field('Nome da empresa')
        expect(page).to have_field('Nome fantasia')
        expect(page).to have_field('Número de registro')
        expect(page).to have_field('Email')
        expect(page).to have_field('Endereço completo')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')
        
    end

    it 'com sucesso' do
        f = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        
        visit(suppliers_path)
        click_on('Samsung Corporate SA')
        click_on('Editar')

       fill_in 'Nome da empresa', with: 'Samsung New SA'
       fill_in 'Nome fantasia', with: 'Samsung New'
       fill_in 'Endereço completo', with: 'Rua das Novidades, 1030'
       click_on('Enviar')
       expect(page).to have_content('Fornecedor alterado com sucesso.')
       expect(page).to have_content('Samsung New SA')
       expect(page).to have_content('Rua das Novidades, 1030')
        
    end

    it 'e mantem os campos obrigatórios' do
        f = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        
        visit(suppliers_path)
        click_on('Samsung Corporate SA')
        click_on('Editar')

       fill_in 'Nome da empresa', with: ''
       click_on('Enviar')
       fill_in 'Nome fantasia', with: ''
       click_on('Enviar')
       fill_in 'Endereço completo', with: ''
       click_on('Enviar')
       expect(page).to have_content('Não foi possível alterar o fornecedor.')
       expect(page).to have_field('Nome da empresa')
       expect(page).to have_field('Nome fantasia')
    end


end
