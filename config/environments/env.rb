# -*- encoding : utf-8 -*-
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'resty.co.kr',
  :user_name            => 'help@resty.co.kr',
  :password             => 'resty0808',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }
