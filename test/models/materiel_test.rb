require 'test_helper'

class MaterielTest < ActiveSupport::TestCase
  # save equipment
  test "save equipment" do
      equipment = Materiel.new
      equipment.name = "Projetor"
      equipment.patrimony = "20150978"
      assert equipment.save
  end

  # should not save equipment (empty fields)
  test "should not save equipment without name" do
      equipment = Materiel.new
      equipment.patrimony = "20150978"
      assert_not equipment.save
  end

  test "should not save equipment without patrimony" do
      equipment = Materiel.new
      equipment.name = "Projetor"
      assert_not equipment.save
  end

  test "should not save equipment with name less than 2 characters" do
      equipment = Materiel.new
      equipment.name = "P"
      equipment.patrimony = "202"
      assert_not equipment.save
  end

  # Should not save (minimum length required) 
  test "should not save equipment with patrimony less than 3 characters" do
      equipment = Materiel.new
      equipment.name = "Projetor"
      equipment.patrimony = "20"
      assert_not equipment.save
  end
end
