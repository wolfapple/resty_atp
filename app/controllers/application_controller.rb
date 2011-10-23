# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :prepare_for_mobile
  helper_method :graph
  
  protected
  def graph
    if session[:access_token]
      @graph = Koala::Facebook::GraphAPI.new(session[:access_token])
    else
      nil
    end
  end
  
  def not_authenticated
    redirect_to login_path, :alert => '로그인이 필요합니다.'
  end
  
  private
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
  
  def prepare_for_mobile
    request.format = :mobile if request.server_name[0] == 'm'
  end
end
