# -*- encoding : utf-8 -*-
class RoomsController < ApplicationController
  def index
    @pension = Pension.find(params[:pension_id])
    @rooms = @pension.rooms
    render :layout => 'colorbox'
  end
end
