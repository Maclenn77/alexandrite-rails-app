# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/books', type: :request do
  path '/books/create' do
    post 'Add a book' do
      tags 'Books'
      consumes 'application/json'
      parameter name: :key, in: :query, type: :string
      parameter name: :query, in: :query, type: :string

      response '200', 'book created' do
        let(:book) { { key: 'isbn', query: '9789682709302' } }
        run_test!
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
  end
end
