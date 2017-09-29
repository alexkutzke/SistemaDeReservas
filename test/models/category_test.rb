require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should not save category without a name" do
      category = Category.new
      assert_not category.save
  end

  test "should not save category with a name lower than 3 characters" do
    category = Category.new
    category.name = "um"
    assert_not category.save
  end

  test "should save category" do
    category = Category.new
    category.name = "Laboratório"
    assert category.save
  end

  test "should return a not empty list of categories" do
    category = Category.all
    assert_not_empty category
  end

  test "should return two register" do
    category = Category.count
    assert_equal 2, category
  end
end
