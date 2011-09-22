# -*- encoding : utf-8 -*-
class PensionsController < ApplicationController
  def index
    @pensions = Pension.page(params[:page]).per(5)
    @pensions = @pensions.by_addr1(params[:addr1]) if params[:addr1]
    @pensions = @pensions.by_addr2(params[:addr2]) if params[:addr2]
    @theme = Theme.find(params[:theme_id]) if params[:theme_id]
    @spot = Spot.find(params[:spot_id]) if params[:spot_id]
    
  end
  
  def show
    @pension = Pension.find(params[:id])
    @reviews = @pension.reviews
    @naver_results = NaverBlog.search(@pension.title)
    @daum_results = DaumBlog.search(@pension.title)
  end
end
