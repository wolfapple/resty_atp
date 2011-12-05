# -*- encoding : utf-8 -*-
class Api::PensionsController < ActionController::Base
  respond_to :json, :xml
  
  def index
    per = params[:per].present?? params[:per] : 10
    distance = params[:distance].present?? params[:distance] : 10
    if params[:spot_id].present?
      spot = Spot.find(params[:spot_id])
      point = [spot.latitude, spot.longitude]
      @pensions = Pension.near(point, distance, {:units => :km, :order => :distance})
    elsif params[:latitude].present? and params[:longitude].present?
      point = [params[:latitude].to_f, params[:longitude].to_f]
      @pensions = Pension.near(point, distance, {:units => :km, :order => :distance})
    else
      @pensions = Pension
    end
    @pensions = @pensions.page(params[:page]).per(per)
    respond_with(:total_page => @pensions.num_pages, :pensions => @pensions)
  end
  
  def show
    @pension = Pension.find(params[:id])
    respond_with(@pension)
  end
end
