# -*- encoding : utf-8 -*-
class PensionReviewsController < ApplicationController
  before_filter :store_location
  before_filter :require_login, :except => [:detail, :helpful]
  
  def index
    @pension = Pension.find(params[:pension_id])
    @reviews = @pension.reviews.page(params[:page]).per(5)
  end
    
  def new
    @pension = Pension.find(params[:pension_id])
    @review = PensionReview.new
    @near_by_pensions = @pension.near_by(5)
    @coupons = Coupon.ing.order('rand()').limit(5)
  end
  
  def create
    params[:pension_review][:user_id] = current_user.id
    @pension = Pension.find(params[:pension_id])
    @review = @pension.reviews.new(params[:pension_review])
    if @review.save
      graph.put_wall_post("'#{@pension.title}' 에 대한 리뷰를 작성하였습니다. #{@pension.resty_url}") if params[:facebook]
      redirect_to @pension
    else
      @near_by_pensions = @pension.near_by(5)
      @coupons = Coupon.ing.order('rand()').limit(5)
      render :new
    end
  end
  
  def destroy
    @pension = Pension.find(params[:pension_id])
    @review = PensionReview.find(params[:id])
    @review.destroy
  end
  
  def detail
    @review = PensionReview.find(params[:id])
  end
  
  def helpful
    @review = PensionReview.find(params[:id])
    if cookies[:resty_helpful_reviews].nil?
      helpful_reviews = []
    else
      helpful_reviews = cookies[:resty_helpful_reviews].split(',')
    end
    if helpful_reviews.include?(@review.id.to_s)
      @msg = "이 리뷰는 이미 평가하셨습니다."
    else
      @review.increment! :helpful
      cookies[:resty_helpful_reviews] = helpful_reviews.push(@review.id).join(',')
      @msg = "투표해주셔서 감사합니다."
    end
  end
end
