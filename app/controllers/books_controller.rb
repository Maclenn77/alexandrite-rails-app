require 'alexandrite'
require 'pry'

class BooksController < ApplicationController
  include Alexandrite

  before_action :get_book_data, only: :create

  def create    binding.pry
    book = @book.except(:data_source)
    book[:book_id] = params['query'].to_i

    unless book[:error_message]
      return Book.create(book)
    end

    error_message = {:message => @book[:error_message],
                     :origin => @book[:data_source],
                     :details => "Key: #{params['key']}. Query: #{params['query']}"}

    ErrorMessage.create(error_message)
  end

  def bulk_new
    binding.pry
  end

  def index

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
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
