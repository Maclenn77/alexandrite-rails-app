require 'test_helper'

class ErrorMessagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get error_messages_index_url
    assert_response :success
  end

  test 'should get show' do
    get error_messages_show_url
    assert_response :success
  end

  test 'should get delete' do
    get error_messages_delete_url
    assert_response :success
  end

  test 'should get delete_all' do
    get error_messages_delete_all_url
    assert_response :success
  end
end
