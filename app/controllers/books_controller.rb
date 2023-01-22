require 'alexandrite'
require 'pry'

class BooksController < ApplicationController
  include Alexandrite

  before_action :get_book_data, only: :create
  before_action :get_bulk_data, only: :bulk


  def create
    return Book.create(@book.except(:key)) unless @book[:error_message]

    error_message = create_error_message(@book)

    ErrorMessage.create(error_message)
  end

  def bulk
    key = params['key']
    data = params['data'].split(',')
    count = { created: 0,
              errors: 0
    }

    @books.each_with_index do |book, i|
      book[:book_id] = data[i]
      book[:key] = key

      if book[:error_message]
        count[:errors] += 1
        error_message = create_error_message(book)

        ErrorMessage.create(error_message)
      else
        count[:created] += 1
        Book.create(book.except(:key))
      end
    end

    render plain: "Added #{count[:created]} new books. #{count[:errors]} books failed. Check logs for more details",
           status: :ok
  end

  def ddc

  end

  def edit
  end

  def delete
  end

  private

  def get_book_data
    key = params['key']
    query = params['query']
    @book = create_book(key, query)
    @book[:book_id], @book[:key] = query.to_i, key
  end

  def create_error_message(info)
    {:message => info[:error_message],
    :origin => info[:data_source],
    :details => "Key: #{info[:key]}. Query: #{info[:book_id]}"}
  end

  def get_bulk_data
    key = params['key']
    data = params['data'].split(',')
    @books = bulk_create(key, data)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
