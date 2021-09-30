require 'rails_helper'

describe 'Books API', type: :request do
    it 'returns all books' do
        FactoryBot.create(:book, title: '1980', author: 'Sergio')
        FactoryBot.create(:book, title: 'Lo que el viento', author: 'Moreno')
        get '/api/v1/books'

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
    end
end