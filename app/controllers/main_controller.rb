# -*- encoding : utf-8 -*-
class MainController < ApplicationController
  def index
    if !mobile_device?
      @areas = Area.all
      @spots = Spot.main
      @themes = Theme.all
      @must_visits = MustVisit.main
      @notices = Notice.recent
      @coupons = Coupon.main
    end
  end
end
