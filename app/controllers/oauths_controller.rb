# -*- encoding : utf-8 -*-
class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to root_url, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session
        login_user(@user)
        redirect_to root_url, :notice => "Logged in from #{provider.titleize}!"
      rescue 
        redirect_to root_url, :alert => "Failed to login from #{provider.titleize}!"
      end      
    end
  end
end
