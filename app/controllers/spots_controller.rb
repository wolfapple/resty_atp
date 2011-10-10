# -*- encoding : utf-8 -*-
class SpotsController < ApplicationController
  def show
    @spot = Spot.find(params[:id])
    @title = @spot.title
    @area = @spot.area
    @sub_area = @spot.sub_area
    @spots = @sub_area.spots
    @reviews = @spot.reviews.page(params[:page]).per(5)
    @near_by_pensions = @spot.near_by_pensions
    if @spot.pensions_count <= 10
      @pensions = @sub_area.pensions.limit(10)
    else
      @pensions = @spot.pensions.limit(10)
    end
    @activities = graph.search(@sub_area.title, {:limit => 3}) if current_user
  end
  
  def update_like_count
    @spot = Spot.find(params[:id])
    if params[:remove]
      @spot.decrement! :like_count
    else
      @spot.increment! :like_count
    end
    render :json => @spot.like_count
  end
  
  def update_comments_count
    @spot = Spot.find(params[:id])
    if params[:remove]
      @spot.decrement! :comments_count
    else
      @spot.increment! :comments_count
    end
    render :json => @spot.comments_count
  end
end
