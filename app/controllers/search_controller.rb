# -*- encoding : utf-8 -*-
class SearchController < ApplicationController
  def result
    SearchLog.create(:input => params[:address], :remote_ip => request.remote_ip)
    if params[:latitude].present? and params[:longitude].present?
      point = [params[:latitude].to_f, params[:longitude].to_f]
      @pensions = Pension.near(point, 10, {:units => :km, :order => :distance})
      @spots = Spot.near(point, 10, {:units => :km, :order => :distance})
      pension_markers = @pensions.collect {|x| {:key => "pension-#{x.id}", :latitude => x.latitude, :longitude => x.longitude, :html => x.html}}
      spot_markers = @spots.collect {|x| {:key => "spot-#{x.id}", :latitude => x.latitude, :longitude => x.longitude, :html => x.html, :icon => {:image => 'http://www.google.com/mapfiles/marker_green.png'}}}
      @results = (pension_markers + spot_markers).to_json
    end
    # 펜션바로가기
    addr = params[:address].gsub('팬션', '펜션')
    like = addr.split(' ').collect {|x| "title like '%#{x.strip}%'"}.join(' and ')
    @pension_links = Pension.where(like).limit(3)
  end
    
  def autocomplete
    if params[:term].mb_chars.length >= 2
      like = params[:term].concat("%")
      # areas = Area.where("title like ?", like).map do |area|
      #   {:id => area.id, :label => "#{area.title}", :category => "지역", :search_class => 'Area'}
      # end
      # sub_areas = SubArea.where("title like ?", like).map do |sub_area|
      #   {:id => sub_area.id, :label => "#{sub_area.area.title}>#{sub_area.title}", :category => "지역", :search_class => 'SubArea'}
      # end
      pensions = Pension.where("title like ?", like).order('ranking desc').limit(10).map do |pension|
        {:id => pension.id, :label => "#{pension.title} - #{pension.sub_area.title}", :category => '펜션', :search_class => 'pensions'}
      end
      spots = Spot.where("title like ?", like).map do |spot|
        {:id => spot.id, :label => spot.title, :category => '관광지', :search_class => 'spots'}
      end
      render :json => pensions + spots
    end
  end
end
