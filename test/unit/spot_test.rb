# -*- encoding : utf-8 -*-
require 'test_helper'

class SpotTest < ActiveSupport::TestCase
  test "check total count" do
    count = Spot.count
    assert_equal count, 3
  end
  
  test "first spot is jara" do
    spot = Spot.first
    assert_equal spot.title, '자라섬'
  end
  
  test "check pension count by spot" do
    count = 0
    Spot.all.each do |spot|
      count += 1 if spot.pensions_count == spot.pensions.count
    end
    assert_equal Spot.count, count
  end
end
