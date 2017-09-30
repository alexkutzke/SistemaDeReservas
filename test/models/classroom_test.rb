require 'test_helper'

class ClassroomTest < ActiveSupport::TestCase
  # save classroom
  test "save classroom" do
      classroom = Classroom.new
      classroom.room = "A10"
      classroom.building = "Bloco A"
      classroom.capacity = 30
      classroom.category_id = 1
      assert classroom.save
  end

  # should not save classroom (empty fields)
  # minimum length required = 1
  test "should not save classroom without a room" do 
    classroom = Classroom.new
    classroom.building = "Bloco A"
    classroom.capacity = 30
    classroom.category_id = 1
    assert_not classroom.save
  end

  test "should not save classroom without a building" do 
    classroom = Classroom.new
    classroom.room = "A01"
    classroom.capacity = 30
    classroom.category_id = 1
    assert_not classroom.save
  end

  test "should not save classroom without a capacity" do 
    classroom = Classroom.new
    classroom.room = "A01"
    classroom.building = "Bloco A"
    classroom.category_id = 1
    assert_not classroom.save
  end

  test "should not save classroom without a category id" do 
    classroom = Classroom.new
    classroom.room = "A01"
    classroom.building = "Bloco A"
    classroom.capacity = 30
    assert_not classroom.save
  end
end
