# -*- encoding : utf-8 -*-
class ReviewsController < ApplicationController
  before_filter :require_login
  
  def index
    if params[:type] == 'pensions'
      @reviews = PensionReview.page(params[:page]).per(5)
    elsif params[:type] == 'spots'
      @reviews = SpotReview.page(params[:page]).per(5)
    end
    params[:controller] = params[:type]
  end
  
  def create
    if params[:review][:pension_id]
      @review = PensionReview.new(params[:review])
      if @review.save
        graph.put_wall_post(params[:review][:content]) if params[:facebook]
        redirect_to @review.pension
      else
        render :controller => :pensions, :action => :show
      end
    else
      @review = SpotReview.new(params[:review])
      if @review.save
        graph.put_wall_post(params[:review][:content]) if params[:review][:facebook]
        redirect_to @review.spot
      else
        render :controller => :spots, :action => :show
      end
    end
  end
  
  def destroy
    if params[:type] == 'pension'
      @review = PensionReview.find(params[:id])
      @pension = @review.pension
      @review.destroy
      redirect_to @pension
    else
      @review = SpotReview.find(params[:id])
      @spot = @review.spot
      @review.destroy
      redirect_to @spot
    end
  end
end
