# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      login_user(@user)
      redirect_to root_url, :notice => '회원 가입 완료!'
    else
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => '회원 정보 수정 완료!'
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url
  end
end
