class ErrorMessagesController < ApplicationController
  before_action :set_error_message, only: %i[show delete]
  def index
    render json: ErrorMessage.all.limit(50), status: :ok
  end

  def show
    render json: @error_message, status: :ok
  end

  def delete
    @error_message.destroy

    render json: { message: 'Error message was deleted successfully.' }, status: :ok
  end

  def delete_all
    error_messages = ErrorMessage.all

    error_messages.each { |error| error.destroy! }

    render json: { message: 'Error messages were deleted successfully.' }, status: :ok
  end

  private

  def set_error_message
    @error_message = ErrorMessage.find(params[:id])
  end
end
