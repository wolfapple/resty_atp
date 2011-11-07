# -*- encoding : utf-8 -*-
class SubAreasController < ApplicationController
  def index
    @area = Area.find(params[:area_id])
    @sub_areas = @area.sub_areas
  end
end
