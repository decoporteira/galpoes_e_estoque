require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'falsed when name is empty' do
        warehouse = Warehouse.new(name: '', code: 'RIO',address: 'Endereço', cep: '25000-000', city: 'Rio de Janeiro', area: 1000, description: 'Qualquer descrição')
      
        result = warehouse.valid?

        expect(result).to eq false
      end

      it 'falsed when code is empty' do
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: '',address: 'Endereço', cep: '25000-000', city: 'Rio de Janeiro', area: 1000, description: 'Qualquer descrição')
      
        result = warehouse.valid?

        expect(result).to eq false
      end


      it 'falsed when address is empty' do
        warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO',address: '', cep: '25000-000', city: 'Rio de Janeiro', area: 1000, description: 'Qualquer descrição')
      
        result = warehouse.valid?

        expect(result).to eq false
      end
      
    end

      it 'false when code ir already is use' do
        first_warehouse = Warehouse.create(name: 'Rio de Janeiro', code: 'RIO',address: 'endereço', cep: '25000-000', city: 'Rio de Janeiro', area: 1000, description: 'Qualquer descrição')
        second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO',address: 'endereço', cep: '89000-001', city: 'Niteroi', area: 20000, description: 'Outro texto')
        result = second_warehouse.valid?

        expect(result).to eq false
      end
  end
  describe '#full_description' do
    it 'exibe o nome e o código ' do
      w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBA')

      result = w.full_description

      expect(result).to eq('CBA | Galpão Cuiabá')
    end
  end


end
