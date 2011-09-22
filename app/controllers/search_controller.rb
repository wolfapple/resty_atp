# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def result
    if params[:search_id].blank?
      like = "%#{params[:search_input]}%"
      @pensions = Pension.where("title like ?", like)
      @spots = Spot.where("title like ?", like)
      @themes = Theme.where("title like ?", like)
    else
      item = (eval params[:search_class]).find(params[:search_id])
      redirect_to item
    end
  end
  
  def autocomplete
    like = "%".concat(params[:term].concat("%"))
    pensions = Pension.where("title like ?", like).map do |pension|
      {:id => pension.id, :label => pension.title, :category => '펜션', :class => 'Pension'}
    end
    spots = Spot.where("title like ?", like).map do |spot|
      {:id => spot.id, :label => spot.title, :category => '관광지', :class => 'Spot'}
    end
    themes = Theme.where("title like ?", like).map do |theme|
      {:id => theme.id, :label => theme.title, :category => '테마', :class => 'Theme'}
    end
    render :json => pensions + spots + themes
  end
end
