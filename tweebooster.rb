%w(rubygems haml sinatra  dm-core dm-timestamps dm-types dm-migrations dm-transactions ./constants).each  { |lib| require lib}
require 'awesome_print'
require 'debugger'
require 'omniauth-twitter'

use OmniAuth::Builder do
    provider :twitter, 'hDj7zTiP4yVMdrc81VLxKA', 'C5UoYY9Vm0CnHByIuSBoZmYpfVjrBC25JsTqqVbjQ'
end

configure do
    disable :show_exceptions
    enable :inline_templates
    enable :sessions
end

# Twitter.configure do |config|
#  config.consumer_key = "hDj7zTiP4yVMdrc81VLxKA"
#  config.consumer_secret = "C5UoYY9Vm0CnHByIuSBoZmYpfVjrBC25JsTqqVbjQ"
#  config.oauth_token = "6534742-ESKKIY4cHWQsBhTshnBYWuQRFqNddpRW9BFfmnK67I"
#  config.oauth_token_secret = "CcP8uGMAHruGhz3y5aWiPnY57ySKGh0CsqLKPX2xYg"
# end

ap TWEEBOOSTER_DATA

get '/' do 
    haml :index 
end


get '/signup' do
    redirect to("/auth/twitter")
end

get '/auth/twitter/callback' do
	env['omniauth.auth']
end


DataMapper::Logger.new(STDOUT,  :debug)


DataMapper.setup(:default, ENV['DATABASE_URL'] || 'mysql://root:times@321@localhost/tweebooster')

class Subscriber
  include DataMapper::Resource
  property  :id,          Serial
  property  :created_at,  DateTime 
  property  :twitter_uid,    Integer
  property  :twitter_nickname, String
  property  :access_token,   String , :length =>  1024
  property  :access_token_secret,   String , :length =>  1024
end

DataMapper.finalize
DataMapper.auto_migrate!

__END__

@@ layout
!!! 1.1
%html
  %head
    %title TweeBooster
    %link{:rel => 'stylesheet', :href => 'http://www.blueprintcss.org/blueprint/screen.css', :type => 'text/css'}  
  %body
    .container
      %p
      = yield
      #footer  
        %br
        %br
        %p  
          <a href="/">Home</a>  
        %p 
        copyright @velvetfish ver 0.1     

@@ index
%h1.title TweeBooster
TweeBooster helps you grow your twitter followers. You sign up for the service. We follow 2 people daily on your behalf. In return, they also follow you up. After a few days, we un-follow them. It is as simple as that.
%p
  %a{:href => "/signup"} = Signup
