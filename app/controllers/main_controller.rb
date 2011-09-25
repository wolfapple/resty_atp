# -*- encoding : utf-8 -*-
class MainController < ApplicationController
  def index
    @areas = Area.all
    @spots = Spot.all
    @themes = Theme.all
    @must_visits = MustVisit.all
  end
end
