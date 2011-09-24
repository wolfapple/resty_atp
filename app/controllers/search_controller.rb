# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def result
    if params[:search_id].blank?
      like = "%#{params[:search_input]}%"
      @areas = Pension.select("DISTINCT(addr2), addr1").where("addr2 like ?", like)
      @pensions = Pension.where("title like ?", like)
      @spots = Spot.where("title like ?", like)
      @themes = Theme.where("title like ?", like)
    else
      if params[:search_class] == 'Area'
        item = Pension.find(params[:search_id])
        redirect_to pensions_path(:addr1 => item.addr1, :addr2 => item.addr2)
      else
        item = (eval params[:search_class]).find(params[:search_id])
        if params[:search_class] == 'Theme'
          redirect_to theme_pensions_path(item)
        else
          redirect_to item
        end
      end
    end
  end
  
  def autocomplete
    like = "%".concat(params[:term].concat("%"))
    areas = Pension.select("DISTINCT(addr2), addr1, id").where("addr2 like ?", like).map do |area|
      {:id => area.id, :label => "#{area.addr1}>#{area.addr2}", :category => "지역", :class => 'Area'}
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
    render :json => areas + pensions + spots + themes
  end
end
