
# Definitely change this when you deploy to production. Ours is replaced by jenkins.
# This token is used to secure sessions, we don't mind shipping with one to ease test and debug,
#  however, the stock one should never be used in production, people will be able to crack
#  session cookies.
#
# Generate a new secret with "rake secret".  Copy the output of that command and paste it
# in your secret_token.rb as the value of Discourse::Application.config.secret_token:
#
# Discourse::Application.config.secret_token = "SET_SECRET_HERE"

raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if ENV['SECRET_TOKEN'].blank?
Discourse::Application.config.secret_token = ENV['SECRET_TOKEN']

#if Rails.env.test? || Rails.env.development? || Rails.env == "profile"
#  Discourse::Application.config.secret_token = "79da3c60627b06c7472af9f5804575a17c9f91d3f765e0d0eb8569923ca76b31cc7d7941641dd014c9cf640bc6159f09700cd5f766a0b59d21f226c5c5028769"
#else
#  raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if ENV['SECRET_TOKEN'].blank?
#  Discourse::Application.config.secret_token = ENV['SECRET_TOKEN']
#end
