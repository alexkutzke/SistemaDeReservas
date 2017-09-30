require 'test_helper'

class PeriodTest < ActiveSupport::TestCase
  # save period
  test "save a period" do
      period = Period.new
      period.name = "TADS 1 D"
      assert period.save
  end

  # should not save period (empty field)
  test "should not save period without a name" do
    period = Period.new
    assert_not period.save
  end

  # should not save save (minimum length required)
  test "should not save period with name less than 3 characters" do
    period = Period.new
    period.name = "TA"
    assert_not period.save
  end
end
