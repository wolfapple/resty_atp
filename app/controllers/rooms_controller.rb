class RoomsController < ApplicationController
  def index
    @pension = Pension.find(params[:pension_id])
    @rooms = @pension.rooms
  end
end
