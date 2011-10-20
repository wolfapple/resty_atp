# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def map
    SearchLog.create(:input => params[:address])
    @point = [params[:latitude].to_f, params[:longitude].to_f]
    @pensions = Pension.near(@point, 10, {:units => :km, :order => :distance, :select => 'longitude, latitude, title, id'})
    @pension_markers = @pensions.collect {|x| {:key => "pension-#{x.id}", :latitude => x.latitude, :longitude => x.longitude, :html => x.html}}
    @spots = Spot.near(@point, 10, {:units => :km, :order => :distance, :select => 'longitude, latitude, title, id'})
    @spot_markers = @spots.collect {|x| {:key => "spot-#{x.id}", :latitude => x.latitude, :longitude => x.longitude, :html => x.html, :icon => {:image => 'http://www.google.com/mapfiles/marker_green.png'}}}
    @results = (@pension_markers + @spot_markers).to_json
  end
  
  def result
    if params[:search_id].blank?
      like = "#{params[:search_input]}%"
      @areas = Area.where("title like ?", like)
      @sub_areas = SubArea.where("title like ?", like)
      @pensions = Pension.where("title like ?", like)
      @spots = Spot.where("title like ?", like)
    else
      item = (eval params[:search_class]).find(params[:search_id])
      if params[:search_class] == 'Area'
        redirect_to area_pensions_path(item)
      elsif params[:search_class] == 'SubArea'
        redirect_to area_sub_area_pensions_path(item.area, item)
      else
        redirect_to item
      end
    end
  end
  
  def autocomplete
    if params[:term].mb_chars.length >= 2
      like = params[:term].concat("%")
      areas = Area.where("title like ?", like).map do |area|
        {:id => area.id, :label => "#{area.title}", :category => "지역", :search_class => 'Area'}
      end
      sub_areas = SubArea.where("title like ?", like).map do |sub_area|
        {:id => sub_area.id, :label => "#{sub_area.area.title}>#{sub_area.title}", :category => "지역", :search_class => 'SubArea'}
      end
      pensions = Pension.where("title like ?", like).order('ranking desc').limit(10).map do |pension|
        {:id => pension.id, :label => pension.title, :category => '펜션', :search_class => 'Pension'}
      end
      spots = Spot.where("title like ?", like).map do |spot|
        {:id => spot.id, :label => spot.title, :category => '관광지', :search_class => 'Spot'}
      end
      render :json => areas + sub_areas + pensions + spots
    end
  end
end
