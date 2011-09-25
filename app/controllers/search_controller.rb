# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def result
    if params[:search_id].blank?
      like = "#{params[:search_input]}%"
      @areas = Area.where("title like ?", like)
      @sub_areas = SubArea.where("title like ?", like)
      @pensions = Pension.where("title like ?", like)
      @spots = Spot.where("title like ?", like)
      @themes = Theme.where("title like ?", like)
    else
      item = (eval params[:search_class]).find(params[:search_id])
      if params[:search_class] == 'Theme'
        redirect_to theme_pensions_path(item)
      elsif params[:search_class] == 'Area'
        redirect_to area_pensions_path(item)
      elsif params[:search_class] == 'SubArea'
        redirect_to area_sub_area_pensions_path(item.area, item)

      else
        redirect_to item
      end
    end
  end
  
  def autocomplete
    like = params[:term].concat("%")
    areas = Area.where("title like ?", like).map do |area|
      {:id => area.id, :label => "#{area.title}", :category => "지역", :class => 'Area'}
    end
    sub_areas = SubArea.where("title like ?", like).map do |sub_area|
      {:id => sub_area.id, :label => "#{sub_area.area.title}>#{sub_area.title}", :category => "지역", :class => 'SubArea'}
    end
    pensions = Pension.where("title like ?", like).map do |pension|
      {:id => pension.id, :label => pension.title, :category => '펜션', :class => 'Pension'}
    end
    spots = Spot.where("title like ?", like).map do |spot|
      {:id => spot.id, :label => spot.title, :category => '관광지', :class => 'Spot'}
    end
    themes = Theme.where("title like ?", like).map do |theme|
      {:id => theme.id, :label => theme.title, :category => '테마', :class => 'Theme'}
    end
    render :json => areas + sub_areas + pensions + spots + themes
  end
end
