require 'rails_helper'

describe 'Usuário editar um galpão' do
    it 'a partir da página de detalhes' do
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                        address: 'Avenida do Aeroporto, 1080', cep: '15000-000',
                                        description: 'Galpão destinado para cargas internacionais')
        visit root_path
        click_on 'Aeroporto SP'
        click_on 'Editar'       
        
        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Nome', with: 'Aeroporto SP')
        expect(page).to have_field('Cidade', with: 'Guarulhos')
        expect(page).to have_field('Área', with: '10000')
        expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1080')
        expect(page).to have_field('CEP', with: '15000-000')   
        expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')
    end

    it 'com sucesso' do
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                        address: 'Avenida do Contorno, 20', cep: '20000-000',
                                        description: 'Galpão destinado para cargas internacionais')
        visit root_path
        click_on 'Aeroporto SP'
        click_on 'Editar' 
        fill_in 'Nome', with: 'Aeroporto Internacional SP'
        fill_in 'Endereço', with: 'Rua das Jades, 3330'  
        fill_in 'CEP', with: '36000-000'   
        fill_in 'Descrição', with: 'Galpão destinado para cargas internacionais e nacionais'
        click_on 'Enviar'
    
        expect(page).to have_content('Galpão editado com sucesso')                                    
        expect(page).to have_content('Nome: Aeroporto Internacional SP')
        expect(page).to have_content('Cidade: Guarulhos')
        expect(page).to have_content('Área: 10000 m2')
        expect(page).to have_content('Descrição: Galpão destinado para cargas internacionais e nacionais')
        expect(page).to have_content('Endereço: Rua das Jades, 3330 - CEP: 36000-000')
        
    end

    it 'e mantem os campos obrigatórios' do
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                                        address: 'Avenida do Contorno, 20', cep: '20000-000',
                                        description: 'Galpão destinado para cargas internacionais')
        visit root_path
        click_on 'Aeroporto SP'
        click_on 'Editar' 
        fill_in 'Nome', with: ''
        fill_in 'Endereço', with: ''  
        fill_in 'Área', with: ''   
        click_on 'Enviar'

        expect(page).to have_content 'Não foi possível atualizar o galpão'
        expect(page).to have_field('Cidade', with: 'Guarulhos')
        expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')

    end
                                        

end
