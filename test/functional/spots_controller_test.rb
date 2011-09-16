# -*- encoding : utf-8 -*-
require 'test_helper'

class SpotsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

end
