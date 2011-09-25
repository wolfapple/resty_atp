# -*- encoding : utf-8 -*-
class PensionsController < ApplicationController
  def index
    @area = Area.find(params[:area_id]) if params[:area_id]
    @sub_area = SubArea.find(params[:sub_area_id]) if params[:sub_area_id]
    @theme = Theme.find(params[:theme_id]) if params[:theme_id]
    @spot = Spot.find(params[:spot_id]) if params[:spot_id]
    if @area
      @spots = @area.spots
      @pensions = @area.pensions
      if @sub_area
        @spots = @spots.where(:sub_area_id => @sub_area.id)
        @pensions = @pensions.where(:sub_area_id => @sub_area.id)
      end
    elsif @theme
      @pensions = @theme.pensions
    elsif @spot
      @pensions = @spot.pensions
    else
      @pensions = Pension
    end
    @pensions = @pensions.page(params[:page]).per(5)
  end
  
  def show
    @pension = Pension.find(params[:id])
    @reviews = @pension.reviews.page(params[:page]).per(5)
    @blog_search = BlogSearch.new(@pension.title, 100)
    @blog_reviews = Kaminari::paginate_array(@blog_search.results).page(params[:page]).per(10)
    @area = @pension.area
    @sub_area = @pension.sub_area
  end
end
