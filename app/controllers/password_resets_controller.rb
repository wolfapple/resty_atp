# -*- encoding : utf-8 -*-
class PasswordResetsController < ApplicationController
  skip_before_filter :require_login
  
  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to login_path, :notice => '이메일이 전송되었습니다.', :alert => '이메일이 전송되었습니다.'
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated if !@user
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to root_url, :notice => '패스워드가 변경되었습니다.'
    else
      render :edit
    end
  end
end
