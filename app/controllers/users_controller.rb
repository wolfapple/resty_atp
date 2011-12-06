# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  before_filter :require_login, :except => [:join, :new, :create]
  
  def join
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      auto_login @user
      redirect_to root_path, :notice => '회원 가입 완료!'
    else
      render :new
    end
  end
  
  # def show
  #   @user = User.find(params[:id])
  # end
  
  def edit
    @user = User.find(params[:id])
    redirect_to root_path, :notice => '잘못된 접근입니다.' unless @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice => '회원 정보 수정 완료!'
    else
      render :edit
    end
  end
  
  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to root_path
  # end
  # 
  # def map
  # end
end
