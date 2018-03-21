# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => ENV['SENDGRIP_USERNAME'],
    :password => ENV['SENDGRIP_PASSWORD'],
    :domain => 'rubyrebels.azurewebsites.net',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
}
