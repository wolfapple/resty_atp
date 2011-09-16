require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test "check room count in jeju1" do
    count = pensions(:jeju1).rooms.count
    assert_equal count, 2
  end
end
