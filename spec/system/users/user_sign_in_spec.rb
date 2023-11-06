require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        #arrange
        User.create!(name: 'André', email: 'admin@admin.com',password: 'password')

        #act
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Senha', with: 'password'
        within('form') do
            click_on 'Entrar'
        end
        #assert
        expect(page).to have_content 'Login efetuado com sucesso.'
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
        within ('nav') do
            expect(page).to have_content 'André - admin@admin.com'
        end
    end

    it 'e faz logout' do
        User.create!(name: 'Admin', email: 'admin@admin.com', password: 'password')
    
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: 'admin@admin.com'
        fill_in 'Senha', with: 'password'
        within('form') do
            click_on 'Entrar'
        end

    
        within ('nav') do
            expect(page).not_to have_link 'Entrar'
            expect(page).to have_button 'Sair'
        end
        within ('nav') do
            expect(page).to have_content 'admin@admin.com'
        end
    end
end
