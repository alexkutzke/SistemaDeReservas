require 'test_helper'

class KlassTest < ActiveSupport::TestCase
  # save klass
  test "save klass" do
      klass = Klass.new
      klass.name = "TADS T 1"
      klass.period_id = 1
      assert klass.save
  end

  # Should not save (empty fields)
  test "should not save klass without name" do
      klass = Klass.new
      klass.period_id = 1
      assert_not klass.save
  end

  test "should not save klass with empty period id" do
      klass = Klass.new
      klass.name = "TADS T 1"
      assert_not klass.save
  end

  test "should not save klass when period id has letter" do
      klass = Klass.new
      klass.name = "TADS T 1"
      klass.period_id = "1s231"
      assert_not klass.save
  end
end
