# -*- encoding : utf-8 -*-
class MainController < ApplicationController
  def index
    @areas = Area.all
    @spots = Spot.main
    @themes = Theme.all
    @must_visits = MustVisit.main
  end
end
