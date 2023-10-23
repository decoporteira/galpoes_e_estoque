require 'rails_helper'

describe 'Usuário remove um galpão' do
    it 'com sucesso' do
        w = Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10000, cep: '50000-000', city: 'Cuiaba', description: 'Galpão no centro do país', address: 'Av da Torre, 301')
        visit root_path
        click_on 'Cuiaba'
        click_on 'Remover'    

        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).not_to have_content 'Cuiaba'
        expect(page).not_to have_content 'CWB'
    end

    it 'não apaga outros galpões' do
    w_one = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', area: 20000, cep: '340000-000', city: 'Belo Horizonte', description: 'Galpão em minas Gerais', address: 'Av Amazonas, 12')
    w_two = Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10000, cep: '50000-000', city: 'Cuiaba', description: 'Galpão no centro do país', address: 'Av da Torre, 301')
        visit root_path
        click_on 'Cuiaba'
        click_on 'Remover'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).not_to have_content 'Cuiaba'
        expect(page).not_to have_content 'CWB'
        expect(page).to have_content 'Belo Horizonte'
        
    end
end