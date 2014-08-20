Rails.application.configure do
  # All other configuration has been removed for brevity.
  # !!!!! DO NOT COPY THIS FILE DIRECTLY IN YOUR APP !!!!!
  
  
  # tell the application to send email
  config.action_mailer.perform_deliveries = true
  
  # tell the application whether or not it should raise an error if sending email fails
  config.action_mailer.raise_delivery_errors = false # can also be `true'
  
  # Set common defaults for outgoing email messages
  config.action_mailer.default_options = {
    from: 'no-reply@example.com',
    reply_to: 'support@example.com'
    subject: "It's always the same here"
  }
  
  # tell the application which delivery method to use
  #  :smtp     - default. Use config.action_mailer.smtp_settings to configure
  #  :sendmail - Use config.action_mailer.sendmail_settings to configure
  #  :file     - Use config.action_mailer.file_settings to configure
  #  :test     - Saves emails to ActionMailer::Base.deliveries array which you can then
  #              access for testing purposes. 
  
  
  # SMTP Example
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              '0.0.0.0',
    user_name:            Rails.application.secrets.email_config["user_name"],
    password:             Rails.application.secrets.email_config["password"],
    authentication:       :login,
    enable_starttls_auto: true
  }
  
  
  # SENDMAIL Example
  config.action_mailer.delivery_method = :sendmail
  config.action_mail.sendmail_settings = {
    location: '/usr/sbin/sendmail',
    arguments: '-i -t'
  }
  
  
  # FILE Example
  config.action_mailer.delivery_method = :file
  config.action_mailer.file_settings = {
    location: '/path/to/where/you/want/emails/saved' # by default, this is /tmp/mails
  }
end
