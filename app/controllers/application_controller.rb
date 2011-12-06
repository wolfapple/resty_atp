# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile
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
    redirect_to login_path, :notice => '로그인이 필요합니다.'
  end
  
  def store_location
    session[:return_to] = request.env['REQUEST_URI']
  end
  
  def redirect_after_login
    redirect_to (session[:return_to] || root_path), :notice => '로그인 되었습니다.'
    session[:return_to] = nil
  end
  
  private
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  
  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
end
