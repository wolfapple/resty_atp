# -*- encoding : utf-8 -*-
require 'test_helper'

class MustVisitTest < ActiveSupport::TestCase
  test "must visits count" do
    count = MustVisit.count
    assert_equal count, 2
  end
  
  test "first must visit is jeju1" do
    pension = MustVisit.first.pension
    assert_equal pension.title, '서귀포펜션'
  end
end
