# -*- encoding : utf-8 -*-
class PensionsController < ApplicationController
  def index
    # get area and spot
    if params[:area_id]
      @area = Area.find(params[:area_id])
      @spots = @area.spots
      @pensions = @area.pensions
    elsif params[:sub_area_id]
      @sub_area = SubArea.find(params[:sub_area_id])
      @area = @sub_area.area
      @spots = @sub_area.spots
      @pensions = @sub_area.pensions
    end
    # get spot
    if params[:spot_id]
      @spot = Spot.find(params[:spot_id])
      @sub_area = @spot.sub_area
      @area = @sub_area.area
      @spots = @sub_area.spots
      @pensions = @spot.pensions
    end
    # get pensions
    @pensions = Pension unless @pensions
    # get theme
    if params[:theme_id]
      @theme = Theme.find(params[:theme_id])
      @pensions = @pensions.joins(:theme_pensions).where('theme_pensions.theme_id' => @theme.id)
    end
    # get price
    if params[:price_id]
      @price = PriceRange.find(params[:price_id])
      if @price.max == 0
        @pensions = @pensions.where("min_price >= ?", @price.min_price)
      else
        @pensions = @pensions.where("min_price between ? and ?", @price.min_price, @price.max_price)
      end
    end
    # get facilities
    if params[:facilities]
      @facilities = params[:facilities].split(',').map {|x| Facility.find(x)}
      like = @facilities.collect {|x| "facilities01 like '%#{x.title}%'"}.join(' and ')
      @pensions = @pensions.where(like)
    else
      @facilities = []
    end
    # must visit
    if params[:must_visit]
      @pensions = @pensions.joins(:must_visit)
    end
    # order
    @pensions = @pensions.order("#{params[:order_by]} desc") if params[:order_by]
    @pensions = @pensions.page(params[:page]).per(10)
  end
  
  def show
    @pension = Pension.find(params[:id])
    @title = @pension.title
    @area = @pension.area
    @sub_area = @pension.sub_area
    @pensions = @sub_area.pensions.limit(3)
    @reviews = @pension.reviews.page(params[:page]).per(5)
    @blog_search = BlogSearch.new("#{@sub_area.title} #{@pension.title}", 100, "#{@sub_area.id}_#{@pension.id}")
    @blog_reviews = Kaminari::paginate_array(@blog_search.results).page(params[:page]).per(10)
  end
  
  def update_like_count
    @pension = Pension.find(params[:id])
    if params[:remove]
      @pension.decrement! :like_count
    else
      @pension.increment! :like_count
    end
    render :json => @pension.like_count
  end
  
  def update_comments_count
    @pension = Pension.find(params[:id])
    if params[:remove]
      @pension.decrement! :comments_count
    else
      @pension.increment! :comments_count
    end
    render :json => @pension.comments_count
  end
end
