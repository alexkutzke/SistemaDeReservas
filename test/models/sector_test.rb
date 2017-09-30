require 'test_helper'

class SectorTest < ActiveSupport::TestCase
  # save sector
  test "save sector" do
      sector = Sector.new
      sector.name = "SEPT"
      assert sector.save
  end

  # should not save sector (empty fields)
  test "should not save sector without name" do
      sector = Sector.new
      assert_not sector.save
  end

  # should not save sector (minimum length required)
  test "should not save sector with name less than 3 characters" do
      sector = Sector.new
      sector.name = "SE"
      assert_not sector.save
  end
end
