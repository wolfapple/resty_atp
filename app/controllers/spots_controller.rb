# -*- encoding : utf-8 -*-
class SpotsController < ApplicationController
  def show
    @spot = Spot.find(params[:id])
    @reviews = @spot.reviews.page(params[:page]).per(5)
    @pensions = @spot.pensions.page(params[:page]).per(5)
  end
end
