# -*- encoding : utf-8 -*-
require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  test "check total count" do
    count = Theme.count
    assert_equal count, 3
  end
  
  test "first theme is workshop" do
    theme = Theme.first
    assert_equal theme.title, '워크샵'
  end
  
  test "check pension count by theme" do
    count = 0
    Theme.all.each do |theme|
      count += 1 if theme.pensions_count == theme.pensions.count
    end
    assert_equal Theme.count, count
  end
end
