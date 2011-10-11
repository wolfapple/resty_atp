# -*- encoding : utf-8 -*-
class RestyMailer < ActionMailer::Base
  default from: "resty@resty.co.kr"
  
  def contact_email(contact)
    @contact = contact
    mail(:from => contact.email, :to => 'help@resty.co.kr', :subject => "[제휴문의]#{contact.title}")
  end
end
