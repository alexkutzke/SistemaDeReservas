require 'test_helper'

class MaterielsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get materiels_index_url
    assert_response :success
  end

  test "should get show" do
    get materiels_show_url
    assert_response :success
  end

  test "should get edit" do
    get materiels_edit_url
    assert_response :success
  end

  test "should get new" do
    get materiels_new_url
    assert_response :success
  end

end
