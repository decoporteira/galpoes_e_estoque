require 'rails_helper'

describe 'Warehouse API' do
    context 'Get /api/v1/warehouse/1' do
        it 'success' do
            #arrange
            warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
            
            # act
            get "/api/v1/warehouses/#{warehouse.id}"

            #assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
           
            json_response = JSON.parse(response.body)
            expect(json_response['name']).to eq('Aeroporto SP')
            expect(json_response['code']).to eq('GRU')
            expect(json_response.keys).not_to include('created_at')
            expect(json_response.keys).not_to include('updated_at')
        end

        it 'fail if warehouse not found' do
            #arrange
            
            # act
            get "/api/v1/warehouses/9999"

            #assert
            expect(response.status).to eq 404
         
        end
    end
    context 'Get /api/v1/warehouses by name' do
        it 'sucess' do
            warehouse_one = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
            warehouse_two = Warehouse.create!(name: 'Aeroporto RJ', code: 'ARJ', city: 'Rio de Janeiro', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais')
            

            get "/api/v1/warehouses"


            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.class).to eq Array
            expect(json_response.length).to eq 2
            expect(json_response[1]['name']).to eq 'Aeroporto SP'
            expect(json_response[0]['name']).to eq 'Aeroporto RJ'
        end

        it 'return empty if theres is no warehouse' do

            get "/api/v1/warehouses"

            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response).to eq []
        end

        it 'and raise iternal error' do

            allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)
            
            get "/api/v1/warehouses"

            expect(response).to have_http_status(500)
            
        end


    end

    context 'Post /api/v1/warehouses' do
        it 'success' do
            warehouse_params = { warehouse: {name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais'}}
            
            post '/api/v1/warehouses', params: warehouse_params

            expect(response).to have_http_status(:created)
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response['name']).to eq('Aeroporto SP')
            expect(json_response['code']).to eq('GRU')
            
        end

        it 'fails ' do
            warehouse_params = { warehouse: {name: 'Aeroporto SP', code: 'GRU', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais'}}
            
            post '/api/v1/warehouses', params: warehouse_params

            expect(response).to have_http_status(412)
            expect(response.body).to include 'Cidade não pode ficar em branco'
           
        end

    end

        it 'fails if theres an internat error' do
            allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
            
            warehouse_params = { warehouse: {name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 10_000, address: 'Avenida do Contorno, 20', cep: '20000-000', description: 'Galpão destinado para cargas internacionais'}}
            
            post '/api/v1/warehouses', params: warehouse_params

            expect(response).to have_http_status(500)
           
       
    end
end
