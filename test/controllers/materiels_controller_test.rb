require 'test_helper'

class MaterielsControllerTest < ActionDispatch::IntegrationTest
  # test "should get index" do
  #   get "/equipments"
  #   assert_response :success
  # end

  # test "should get show" do
  #   get "/equipments/1/show"
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get "/equipments/1/edit"
  #   assert_response :success
  # end

  test "should get new" do
    get "/equipments/new"
    assert_response :success
  end

end
