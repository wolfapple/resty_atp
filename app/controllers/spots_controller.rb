# -*- encoding : utf-8 -*-
class SpotsController < ApplicationController
  def show
    @spot = Spot.find(params[:id])
    @reviews = @spot.reviews
    @pensions = @spot.pensions
  end
end
