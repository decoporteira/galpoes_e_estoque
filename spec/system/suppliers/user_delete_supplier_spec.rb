require 'rails_helper'

describe 'Usuário remove um galpão' do
    it 'com sucesso' do
        f = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        
        visit suppliers_path
        click_on 'Samsung Corporate SA'
        click_on 'Remover'

        expect(current_path).to eq suppliers_path
        expect(page).to have_content 'Fornecedor removido com sucesso'
        expect(page).not_to have_content 'Samsung Corporate SA'
        expect(page).not_to have_content '32423423'

    end

    it 'não apaga outros galpões' do
        f_one = Supplier.create!(corporate_name: 'Samsung Corporate SA', brand_name: 'Samsung', city: 'Rio de Janeiro', registration_number: '32423423', full_address: "Rua das Casas, 180", state: "RJ", email: "contato@samsung.com.br")
        f_two = Supplier.create!(corporate_name: 'Xiaomi Corporate SA', brand_name: 'Xiaomi', city: 'São Paulo', registration_number: '300', full_address: "Rua dos Celulares, 200", state: "RJ", email: "xiaomi@xiaomi.com.br")
        
        visit suppliers_path
        click_on 'Samsung Corporate SA'
        click_on 'Remover'

        expect(current_path).to eq suppliers_path
        expect(page).to have_content 'Fornecedor removido com sucesso'
        expect(page).not_to have_content 'Samsung Corporate SA'
        expect(page).not_to have_content '32423423'
        expect(page).to have_content 'Xiaomi Corporate SA'
        expect(page).to have_content 'São Paulo'

        
    end
end