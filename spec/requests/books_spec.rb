require 'rails_helper'

describe 'Books API', type: :request do
    describe 'GET /books' do
        it 'returns all books' do
            FactoryBot.create(:book, title: '1980', author: 'Sergio')
            FactoryBot.create(:book, title: 'Lo que el viento', author: 'Moreno')
            get '/api/v1/books'
    
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end

    describe 'POST /books' do
        it 'create a new book' do
            expect {
                post '/api/v1/books', params: { 
                    book: {title: 'The Martian'},
                    author: {first_name: 'Andy', last_name: 'Weir', age: '48'}
                }
            }.to change { Book.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
            expect(Author.count).to eq(1)
            expect(JSON.parse(response.body)).to eq(
                {
                    'id' => 1,
                    'title' => 'The Martian',
                    'author_name' => 'Andy Weir',
                    'author_age' => 48
                }
            )
        end
    end

    describe 'DELETE /books' do
        it 'deletes a book' do
            book = FactoryBot.create(:book, title: '1980', author: 'Sergio')
            delete "/api/v1/books/#{book.id}"
            
            expect(response).to have_http_status(:no_content)
        end
    end
end