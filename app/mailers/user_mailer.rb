# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "resty@resty.co.kr"
  
  def reset_password_email(user)
    @user = user
    @url = "http://www.resty.co.kr/password_resets/#{user.reset_password_token}/edit"
    mail to: user.email, :subject => 'Your password has been reset'
  end
end
