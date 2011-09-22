# -*- encoding : utf-8 -*-
class PasswordResetsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to root_url, :notice => 'Instructions have been sent to your email'
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated if !@user
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated if !@user
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to root_url, :notice => 'Password was successfully updated'
    else
      render :edit
    end
  end
end
