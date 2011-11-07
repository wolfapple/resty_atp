# -*- encoding : utf-8 -*-
class SpotsController < ApplicationController
  def index
    if params[:area_id]
      @area = Area.find(params[:area_id])
      @spots = @area.spots
    elsif params[:sub_area_id]
      @sub_area = SubArea.find(params[:sub_area_id])
      @area = @sub_area.area
      @spots = @sub_area.spots
    else
      @spots = Spot.all
    end
    if params[:map]
      @markers = @spots.collect {|x| {:latitude => x.latitude, :longitude => x.longitude, :html => x.html(true)}}.to_json
      render 'map'
    end
  end
  
  def show
    @spot = Spot.find(params[:id])
    @title = @spot.title
    @area = @spot.area
    @sub_area = @spot.sub_area
    @spots = @sub_area.spots
    @reviews = @spot.reviews.page(params[:page]).per(5)
    @near_by_pensions = @spot.near_by_pensions
    @pensions = @near_by_pensions[0...10]
    #@activities = graph.search(@sub_area.title, {:limit => 3}) if current_user
    @markers = [{:latitude => @spot.latitude, :longitude => @spot.longitude}].to_json
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
