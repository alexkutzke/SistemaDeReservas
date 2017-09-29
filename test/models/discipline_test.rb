require 'test_helper'

class DisciplineTest < ActiveSupport::TestCase
  # save discipline
  test "save discipline" do
      discipline = Discipline.new
      discipline.name = "Introdução a banco de dados"
      discipline.discipline_code = "TI123"
      discipline.department_id = 1
      assert discipline.save
  end

  # Should not save (empty fields)
  test "shoud not save discipline without name" do
      discipline = Discipline.new
      discipline.discipline_code = "TI123"
      discipline.department_id = 1
      assert_not discipline.save
  end

  test "shoud not save discipline without discipline code" do
      discipline = Discipline.new
      discipline.name = "Introdução a banco de dados"
      discipline.department_id = 1
      assert_not discipline.save
  end 

  test "shoud not save discipline without department id" do
      discipline = Discipline.new
      discipline.name = "Introdução a banco de dados"
      discipline.discipline_code = "TI123"
      assert_not discipline.save
  end 

  # Should not save (minimum length required) 
  test "should not save discipline  = name less than 3 characters" do
      discipline = Discipline.new
      discipline.name = "In"
      discipline.discipline_code = "TI123"
      discipline.department_id = 1
      assert_not discipline.save
  end

  test "should not save discipline  = discipline code less than 3 characters" do
      discipline = Discipline.new
      discipline.name = "Introdução a banco de dados"
      discipline.discipline_code = "23"
      discipline.department_id = 1
      assert_not discipline.save
  end

  test "should not save discipline  = department id less than 1 characters" do
      discipline = Discipline.new
      discipline.discipline_code = "TI123"
      discipline.department_id = 
      assert_not discipline.save
  end
end
