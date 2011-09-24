# -*- encoding : utf-8 -*-
class PensionsController < ApplicationController
  def index
    @theme = Theme.find(params[:theme_id]) if params[:theme_id]
    @spot = Spot.find(params[:spot_id]) if params[:spot_id]
    if @theme
      @pensions = @theme.pensions
    elsif @spot
      @pensions = @spot.pensions
    else
      @pensions = Pension
    end
    @pensions = @pensions.page(params[:page]).per(5)
    @pensions = @pensions.by_addr1(params[:addr1]) if params[:addr1]
    @pensions = @pensions.by_addr2(params[:addr2]) if params[:addr2]
  end
  
  def show
    @pension = Pension.find(params[:id])
    @reviews = @pension.reviews.page(params[:page]).per(5)
    @blog_search = BlogSearch.new(@pension.title, 100)
    @blog_reviews = Kaminari::paginate_array(@blog_search.results).page(params[:page]).per(10)
    params[:addr1] = @pension.addr1
    params[:addr2] = @pension.addr2
  end
end
