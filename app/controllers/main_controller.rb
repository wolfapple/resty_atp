# -*- encoding : utf-8 -*-
class MainController < ApplicationController
  def index
    @areas = Area.all
    @spots = Spot.main
    @themes = Theme.all
    @must_visits = MustVisit.main
    @notices = Notice.recent
    @coupons = Coupon.main
  end
  
  def mobile_index
  end
end
