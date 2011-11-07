# -*- encoding : utf-8 -*-
class AreasController < ApplicationController
  def index
    @areas = Area.all
  end
end
