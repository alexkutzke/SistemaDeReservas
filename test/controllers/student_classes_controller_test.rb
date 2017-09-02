require 'test_helper'

class StudentClassesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_classes_index_url
    assert_response :success
  end

  test "should get new" do
    get student_classes_new_url
    assert_response :success
  end

  test "should get edit" do
    get student_classes_edit_url
    assert_response :success
  end

  test "should get show" do
    get student_classes_show_url
    assert_response :success
  end

end
