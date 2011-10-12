# -*- encoding : utf-8 -*-
class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to root_url
      session[:access_token] = @provider.get_access_token({:code => params[:code]}).token
      remember_me!
    else
      begin
        @user = create_from(provider)
        reset_session
        login_user(@user)
        redirect_to root_url
        session[:access_token] = @provider.get_access_token({:code => params[:code]}).token
        remember_me!
      rescue 
        redirect_to root_url, :alert => "로그인 실패"
      end      
    end
  end
end
