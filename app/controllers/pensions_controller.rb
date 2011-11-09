# -*- encoding : utf-8 -*-
class PensionsController < ApplicationController
  def index
    # get area and spot
    if !params[:sub_area_id].blank?
      @sub_area = SubArea.find(params[:sub_area_id])
      @area = @sub_area.area
      @spots = @sub_area.spots
      @pensions = @sub_area.pensions
    elsif !params[:area_id].blank?
      @area = Area.find(params[:area_id])
      @spots = @area.spots
      @pensions = @area.pensions
    end
    # get spot
    if !params[:spot_id].blank?
      @spot = Spot.find(params[:spot_id])
      @sub_area = @spot.sub_area
      @area = @sub_area.area
      @spots = @sub_area.spots
      @pensions = @spot.pensions
    end
    # get pensions
    @pensions = Pension unless @pensions
    # get theme
    if !params[:theme_id].blank?
      @theme = Theme.find(params[:theme_id])
      @pensions = @pensions.joins(:theme_pensions).where('theme_pensions.theme_id' => @theme.id)
    end
    # get price
    if !params[:price_id].blank?
      @price = PriceRange.find(params[:price_id])
      if @price.max == 0
        @pensions = @pensions.where("min_price >= ?", @price.min)
      else
        @pensions = @pensions.where("min_price between ? and ?", @price.min, @price.max)
      end
      @pensions = @pensions.where("min_price <> 0")
    end
    # get facilities
    if !params[:facilities].blank?
      if params[:facilities].kind_of? Array
        @facilities = params[:facilities].map {|x| Facility.find(x)}
      else
        @facilities = params[:facilities].split(',').map {|x| Facility.find(x)}
      end
      like = @facilities.collect {|x| "facilities like '%#{x.title}%'"}.join(' and ')
      @pensions = @pensions.where(like)
    else
      @facilities = []
    end
    # must visit
    if params[:must_visit]
      @pensions = @pensions.joins(:must_visit)
    end
    # social commerce
    if params[:coupon]
      @pensions = @pensions.joins(:coupon).group("coupons.pension_id")
    end
    # order
    @total = @pensions.count
    @pensions = @pensions.reorder("#{params[:order_by]} desc") if params[:order_by]
    @pensions = @pensions.page(params[:page]).per(10)
    @markers = @pensions.collect {|x| {:latitude => x.latitude, :longitude => x.longitude, :html => x.html_list}}.to_json
  end
  
  def show
    @pension = Pension.find(params[:id])
    @title = @pension.title
    @area = @pension.area
    @sub_area = @pension.sub_area
    @spots = @sub_area.spots
    @near_by_pensions = @pension.near_by
    @reviews = @pension.reviews.page(params[:page]).per(5)
    @blog_search = BlogSearch.new("#{@sub_area.title} #{@pension.title}", 20, "#{@sub_area.id}_#{@pension.id}")
    @blog_reviews = Kaminari::paginate_array(@blog_search.results).page(params[:page]).per(5)
    #@activities = graph.search(@sub_area.title, {:limit => 3}) if current_user
    @markers = [{:latitude => @pension.latitude, :longitude => @pension.longitude}].to_json
    @coupon = @pension.coupon
  end
  
  def nearby
    @pension = Pension.find(params[:id])
    @pensions = @pension.near_by
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
