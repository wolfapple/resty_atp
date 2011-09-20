# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  def not_authenticated
    redirect_to login_path, :alert => '로그인이 필요합니다.'
  end
end
