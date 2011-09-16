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
end
