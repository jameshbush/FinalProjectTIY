require 'test_helper'

class JourneyTest < ActiveSupport::TestCase
  def setup
    @journey = Journey.find(1)
  end

  # Basic Tests

  test "journey has user" do
    assert_equal @journey.quest, Quest.find(1), "Journey lacks user"
  end

  test "journey has quest" do
    assert_equal @journey.user, User.find(1), "Journey lacks quest"
  end

  test "journey has two reports" do
    assert_equal @journey.reports.count, 2, "Journey has incorrect report count"
  end

end
