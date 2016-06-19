require 'test_helper'

class QuestTest < ActiveSupport::TestCase
  test "quest count" do
    assert_equal 3, Quest.count
  end

  test "happiness presence" do
    assert Quest.all.include? Quest.find_by(grail: "happiness")
  end

  test "confidence presence" do
    assert Quest.all.include? Quest.find_by(grail: "confidence")
  end

  test "freedom presence" do
    assert Quest.all.include? Quest.find_by(grail: "freedom")
  end
end
