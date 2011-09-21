# -*- encoding : utf-8 -*-
class MainController < ApplicationController
  def index
    @addrs = Pension.addrs
    @spots = Spot.all
    @themes = Theme.all
    @must_visits = MustVisit.all
  end
end
