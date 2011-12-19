# -*- encoding : utf-8 -*-
class ReviewsController < ApplicationController
  before_filter :store_location
  before_filter :require_login
    
  def new
    if params[:pension_id].present?
      @pension = Pension.find(params[:pension_id])
    elsif params[:spot_id].present?
      @spot = Spot.find(params[:spot_id])
    end
  end
  
  def create
    params[:review][:user_id] = current_user.id
    if params[:pension_id].present?
      @pension = Pension.find(params[:pension_id])
      @review = @pension.reviews.new(params[:review])
    elsif params[:spot_id].present?
      @spot = Spot.find(params[:spot_id])
      @review = @spot.reviews.new(params[:review])
    end
    if @review.save
      graph.put_wall_post(params[:review][:content]) if params[:facebook]
      if @pension.present?
        redirect_to @pension
      else
        redirect_to @spot
      end
    else
      render :new
    end
  end
  
  def destroy
    if params[:pension_id].present?
      @pension = Pension.find(params[:pension_id])
      @review = PensionReview.find(params[:id])
      @review.destroy
      @reviews = @pension.reviews.limit(5)
    elsif params[:spot_id].present?
      @spot = Spot.find(params[:spot_id])
      @review = SpotReview.find(params[:id])
      @review.destroy
      @reviews = @spot.reviews.limit(5)
    end
  end
end
