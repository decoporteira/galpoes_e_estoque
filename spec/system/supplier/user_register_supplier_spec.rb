require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
    it 'a partir da tela inicial' do
        visit(root_path)
        click_on('Fornecedores')
        click_on('Cadastrar Fornecedor')

        expect(page).to have_field('Nome da empresa')
        expect(page).to have_field('Nome fantasia')
        expect(page).to have_field('Número de registro')
        expect(page).to have_field('Email')
        expect(page).to have_field('Endereço completo')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Estado')

    end
    it 'e cadastra com sucesso' do
        visit suppliers_path
        click_on('Cadastrar Fornecedor')

        fill_in 'Nome da empresa', with: 'Samsung Corporate SA'
        fill_in 'Nome fantasia', with: 'Samsung'
        fill_in 'Número de registro', with: '200032'
        fill_in 'Email', with: 'samsung@gmail.com'
        fill_in 'Endereço completo', with: 'Rua das Voltas, 2902'
        fill_in 'Cidade', with: 'Juiz de Fora'
        fill_in 'Estado', with: 'MG'

        click_on('Enviar')
        expect(current_path).to eq suppliers_path
        expect(page).to have_content 'Fornecedor cadastrado com sucesso.'
       

    end

end