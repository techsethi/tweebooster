require 'rubygems'
require 'twitter'


Twitter.configure do |config|
  config.consumer_key = "hDj7zTiP4yVMdrc81VLxKA"
  config.consumer_secret = "C5UoYY9Vm0CnHByIuSBoZmYpfVjrBC25JsTqqVbjQ"
  config.oauth_token = "6534742-ESKKIY4cHWQsBhTshnBYWuQRFqNddpRW9BFfmnK67I"
  config.oauth_token_secret = "CcP8uGMAHruGhz3y5aWiPnY57ySKGh0CsqLKPX2xYg"
end

p Twitter.update("I'm tweeting with @gem from Ruby !!")