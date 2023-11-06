require 'rails_helper'

RSpec.describe User, type: :model do
    describe '#description' do
        it 'exibe o nome e o email' do
        u = User.new(name: 'André Pereira', email: 'deco@gmail.com') 

        result = u.description()

        expect(result).to eq ('André Pereira - deco@gmail.com')
        end
            
    end
end
