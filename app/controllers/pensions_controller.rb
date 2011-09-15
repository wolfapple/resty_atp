# -*- encoding : utf-8 -*-
class PensionsController < ApplicationController
  def index
    if params[:addr2]
      @pensions = Pension.by_addr1(params[:addr1]).by_addr2(params[:addr2])
    elsif params[:addr1]
      @pensions = Pension.by_addr1(params[:addr1])
    else
      @pensions = Pension.all
    end
  end
  
  def show
    @pension = Pension.find(params[:id])
  end
end
