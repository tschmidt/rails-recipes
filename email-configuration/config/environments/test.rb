Rails.application.configure do
  # All other configuration has been removed for brevity.
  # !!!!! DO NOT COPY THIS FILE DIRECTLY IN YOUR APP !!!!!
  
  
  # set the delivery method to :test
  config.action_mailer.delivery_method = :test
  # do not allow emails to be delivered
  config.action_mailer.perform_deliveries = false
end
