require 'alexandrite'
require 'pry'

class BooksController < ApplicationController
  include Alexandrite

  before_action :get_book_data, only: :create
  before_action :get_bulk_data, only: :bulk
  before_action :find_book, only: %i[ddc lcc delete show]

  def index
    render json: Book.all.limit(25).order(id: :desc), status: :ok
  end

  def show
    render :json => @book, status: :ok
  end

  def create
    if @book[:error_message].nil?
      result = Book.create(@book.except(:key))
    else
      error_message = create_error_message(@book)

      result = ErrorMessage.create(error_message)
    end

    status = if result.instance_of?(ErrorMessage)
                :unprocessable_entity
              else
                :ok
              end

    render json: @book, status: status
  end

  def bulk
    key = params['key']

    count = { created: 0,
              errors: 0 }

    @books.each_with_index do |book, i|
      book[:book_id] = @data[i]
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
    # TODO: Change with logger
    puts "Errors= #{count[:errors]}. Created = #{count[:created]}"

    render json: Book.all.limit(50),
           status: :ok
  end

  def ddc
    key = params['key']
    query = params['query']

    unless @book.nil?
      suggest_classification(key, query)
      classification = @book.ddc || @book.suggested_classifications.join(', ')
      success_message = "Most common classifications: #{classification}."
    end

    not_found_message = 'Book not found. Try with other values'

    message = @book.nil? ? not_found_message : success_message

    render json: message, status: :ok
  end

  def lcc
    key = params['key']
    query = params['query']

    unless @book.nil?
      suggest_classification(key, query, 'lcc')
      classification = @book.lcc || @book.suggested_classifications.join(', ')
      success_message = "Most common classifications: #{classification}."
    end

    not_found_message = 'Book not found. Try with other values'

    message = @book.nil? ? not_found_message : success_message

    render json: message, status: :ok
  end

  def edit; end

  def delete
    @book.destroy! if @book

    render json: { message: 'Book deleted' }, status: :ok
  end

  private

  def get_book_data
    key = params['key']
    query = params['query']
    @book = create_book(key, query)
    @book[:authors] = [@book[:authors]] if @book[:data_source] == "OCLC API"
    @book[:book_id] = query.to_i
    @book[:key] = key
  end

  def find_book
    return @book = Book.find(params[:id]) if params[:id]

    key = params['key'].to_sym
    query = params['query']
    @book = Book.find_by(key => query.to_i)
  end

  def create_error_message(info)
    { message: info[:error_message],
      origin: info[:data_source],
      details: "Key: #{info[:key]}. Query: #{info[:book_id]}",
      error_id: info[:book_id] }
  end

  def get_bulk_data
    key = params['key']
    @data = File.read(params['data']).split

    @books = bulk_create(key, @data)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def isbn?(key) = key[0..3] == 'isbn' || key == 'book_id'

  def format_key(key)
    return 'isbn' if isbn?(key)
  end

  def get_suggestions?(classification) = @book[classification.to_sym].nil? || !@book.suggested_classifications.empty?

  def suggest_classification(key, query, classification = 'ddc')
    return unless get_suggestions?(classification)

    key = format_key(key)
    suggestions = Alexandrite::OCLC.recommend_classification(key, query, classification)

    @book.suggested_classifications << suggestions if suggestions.instance_of?(String)

    @book.suggested_classifications = suggestions if suggestions.instance_of?(Array)

    @book.save
  end
end
