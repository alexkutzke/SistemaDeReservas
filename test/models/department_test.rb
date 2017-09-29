require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
    test "should not save a Department without a name and place" do
        department = Department.new
        assert_not department.save
    end

    test "should not save a Department without a name" do
        department = Department.new
        department.place = "Politécnico"
        assert_not department.save
    end

    test "should not save a Department without a place" do
        department = Department.new
        department.name = "Departamento de informática"
        assert_not department.save
    end

    test "should not save a Department with name less than 3 character and empty place" do
        department = Department.new
        department.name = "De"
        assert_not department.save
    end

    test "should not save a Department with place less than 3 character and a empty name" do
        department = Department.new
        department.place = "De"
        assert_not department.save
    end

    test "should not save a Department with name and place less than 3 character" do
        department = Department.new
        department.name = "De"
        department.place = "po"
        assert_not department.save
    end

    test "save department" do
        department = Department.new
        department.name = "Departamento de informática"
        department.place = "politécnico"
        assert department.save
    end
end
