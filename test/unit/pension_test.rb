# -*- encoding : utf-8 -*-
require 'test_helper'

class PensionTest < ActiveSupport::TestCase
  test "check_total_count" do
    count = Pension.all.count
    assert_equal count, 6
  end
  
  test "check_count_by_addr1" do
    count = Pension.by_addr1('경기도').count
    assert_equal count, 2
  end
  
  test "check_count_by_addr2" do
    count = Pension.by_addr2('가평').count
    assert_equal count, 1
  end
end
