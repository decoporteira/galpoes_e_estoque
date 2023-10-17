require 'rails_helper'

describe 'Usuario visite tela inicial' do
    it 'e vê o nome do app' do
        visit('/')
        expect(page).to have_content('Galpões & Estoque')
    end
end