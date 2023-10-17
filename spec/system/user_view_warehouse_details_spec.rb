require 'rails_helper'

describe 'ver detalhes dos galpoes' do
    it 'detalhes' do
    #arrange
        w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                            address: 'Avenida do Aeroporto, 1080', cep: '15000-000',
                            description: 'Galpão destinado para cargas internacionais')
        w.save()                        
    # Act
        visit('/')
        click_on('Aeroporto SP')
    # Assert
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: Guarulhos')
    expect(page).to have_content('Área: 10000 m2')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1080 - CEP: 15000-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais')
    end

    it 'e volta para a tela inicial' do
     #arrange    
        w = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000,
                            address: 'Avenida do Aeroporto, 1080', cep: '15000-000',
                            description: 'Galpão destinado para cargas internacionais')
        w.save()
    # Act
        visit(root_path)
        click_on('Aeroporto SP') 
        click_on('Voltar')
    # Assert
       expect(current_path).to eq(root_path)        
    end
end