# -*- encoding : utf-8 -*-
class OauthsController < ApplicationController
  skip_before_filter :require_login
  
  def oauth
    if mobile_device?
      login_at(params[:provider], :mobile => true)
    else
      login_at(params[:provider])
    end
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      session[:access_token] = @provider.get_access_token({:code => params[:code]}).token
      remember_me!
      redirect_to root_url, :notice => '로그인 되었습니다.'
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        session[:access_token] = @provider.get_access_token({:code => params[:code]}).token
        remember_me!
        redirect_to root_url, :notice => '로그인 되었습니다.'
      rescue
        redirect_to root_url, :notice => "로그인에 실패하였습니다."
      end      
    end
  end
end
