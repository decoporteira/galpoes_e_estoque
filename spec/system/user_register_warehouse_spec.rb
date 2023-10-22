require 'rails_helper'

describe 'Usuário cadastra um galpão' do
    it 'a partir da tela inicial' do
        # Arrange

        #act
        visit root_path
        click_on 'Cadastrar Galpão'
        #assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Descrição')
        expect(page).to have_field('Código')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Cep')
        expect(page).to have_field('Área')
    
    end
    it 'Com sucesso' do
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: 'Rio de Janeiro'
        fill_in 'Descrição', with: 'Galpão da zona portuaria do Rio'
        fill_in 'Código', with: 'RIO'
        fill_in 'Endereço', with: 'Aveniado do Museu do Amanhã, 1000'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'Cep', with: '20100-000'
        fill_in 'Área', with: '32000'
        click_on 'Enviar'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão cadastrado com sucesso.'
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content 'RIO'
        expect(page).to have_content '32000 m2'
    end

    it 'com dados incompletos' do
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: ''
        fill_in 'Descrição', with: ''
        click_on 'Enviar'

        expect(page).to have_content 'Galpão não cadastrado.'
    end

end
