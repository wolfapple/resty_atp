# -*- encoding : utf-8 -*-
class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]
  skip_before_filter :user_info_check
  
  def new
  end
  
  def create
    session_backup = session[:return_to]
    user = login(params[:email], params[:password], params[:remember_me])
    session[:return_to] = session_backup
    if user
      redirect_after_login
    else
      flash[:alert] = "로그인에 실패 했습니다!"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => '로그아웃 되었습니다.'
  end
end
