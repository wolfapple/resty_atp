# -*- encoding : utf-8 -*-
class PensionsController < ApplicationController
  def index
    @sub_area = SubArea.find(params[:sub_area_id]) if params[:sub_area_id]
    @area = @sub_area.area if @sub_area
    @area = Area.find(params[:area_id]) if params[:area_id]
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
    @area = @pension.area
    @sub_area = @pension.sub_area
    @pensions = @sub_area.pensions.limit(3)
    @reviews = @pension.reviews.page(params[:page]).per(5)
    @blog_search = BlogSearch.new("#{@sub_area.title} #{@pension.title}", 100, "#{@sub_area.id} #{@pension.id}")
    @blog_reviews = Kaminari::paginate_array(@blog_search.results).page(params[:page]).per(10)
  end
end
