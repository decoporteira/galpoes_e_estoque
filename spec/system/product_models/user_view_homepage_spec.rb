require 'rails_helper'

describe 'Usuario visite tela inicial' do
    it 'e vê o nome do app' do

        visit(root_path)

        expect(page).to have_content('Galpões & Estoque')
        expect(page).to have_link('Galpões & Estoque', href: root_path)
    end

    it 'e ve os galpões cadastrados' do
        # Arrange
        Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, description: "Uma galpão", address: "Av. Gigante, 400", cep: "39003-000")
        Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, description: "Uma galpão", address: "Av. Gigante, 400", cep: "39003-000")
        # Act
        visit(root_path)

        # Assert
        expect(page).not_to have_content('Não existem galpões cadastrados.')
        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('60000 m2')

        expect(page).to have_content('Maceio')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceio')
        expect(page).to have_content('50000 m2')
    end

    it 'e não ve galpões cadastrados' do
        visit(root_path)
        expect(page).to have_content('Não existem galpões cadastrados.')
    end
end