# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/books', type: :request do

  path '/books/create' do
    post 'Add a new book' do
      tags 'Books'
      consumes 'application/json'
      parameter name: :key, in: :query, type: :string, description: "Add a field to query, such as: ISBN, Author or Title"
      parameter name: :query, in: :query, type: :string, description: "Add a query"

      response '200', 'A book was created' do

        let(:book) { { key: 'isbn', query: '9789682709302' } }
        run_test!
      end
    end

    path '/books/bulk' do
      post('bulk create books') do
        tags 'Books'
        consumes 'multipart/form-data'
        parameter name: :key, in: :query, type: :string, description: "A field to query, such as ISBN or ISSN"
        parameter name: :data, in: :formData, type: :file, description: "A file with txt extension, with a value in each new line"

        response '200', 'books created' do
          let(:file_uploaded) { fixture_file_upload('files/isbns.txt', 'text/txt') }
          let(:books) { { key:'isbn', data: :file_uploaded}}
          run_test!
        end
      end
    end

    path '/' do
      get('list books') do
        response(200, 'successful') do
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test!
        end
      end
    end

    path '/books/delete' do
      delete('Delete a book') do
        tags 'Books'
        consumes 'application/json'
        parameter name: :id, in: :query, type: :string, description: "ID of a book in the database"

        response(200, 'successful') do
          let(:id) { 1 }
          let(:delete) { { id: id } }
          run_test!
        end
      end
    end
  end
end
