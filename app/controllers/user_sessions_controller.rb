# -*- encoding : utf-8 -*-
class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]
  
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url
    else
      flash.now.alert = "로그인에 실패 했습니다!"
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url
  end
end
