# -*- encoding : utf-8 -*-
class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      RestyMailer.contact_email(@contact).deliver
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
