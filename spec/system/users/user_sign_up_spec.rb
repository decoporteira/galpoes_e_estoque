require 'rails_helper'

describe 'Usuário cria conta' do
    it 'com sucesso' do
        #arrange
        

        #act
        visit root_path
        click_on 'Entrar'
        click_on 'Criar conta'
        fill_in 'Nome', with: 'Admin'
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('form') do
            click_on 'Criar conta'
        end
        #assert
        expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
        within ('nav') do
            expect(page).to have_content 'Olá Admin'
            expect(page).to have_content 'admin@admin.com'
        end
        user = User.last
        expect(user.name).to eq 'Admin'
    end

    it 'não passa pois nome é obrigatório' do
        #arrange
        

        #act
        visit root_path
        click_on 'Entrar'
        click_on 'Criar conta'
        fill_in 'Nome', with: ''
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('form') do
            click_on 'Criar conta'
        end
        #assert
        expect(page).to have_content 'Nome não pode ficar em branco'
        
    end

end