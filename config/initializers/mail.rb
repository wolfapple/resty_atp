# -*- encoding : utf-8 -*-
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'resty.co.kr',
  :user_name            => 'help@resty.co.kr',
  :password             => 'resty0808',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
