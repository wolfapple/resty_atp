# -*- encoding : utf-8 -*-
class SpotsController < ApplicationController
  def show
    @spot = Spot.find(params[:id])
    @area = @spot.area
    @sub_area = @spot.sub_area
    @reviews = @spot.reviews.page(params[:page]).per(5)
    @pensions = @spot.pensions.page(params[:page]).per(3)
  end
end
