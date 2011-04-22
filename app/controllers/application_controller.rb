class ApplicationController < ActionController::Base
   # Be sure to include AuthenticationSystem in Application Controller instead
   require File.join(Rails.root, 'lib', 'authenticated_system.rb')
   include AuthenticatedSystem
   #protect_from_forgery
   before_filter :parse_facebook_cookies
   def parse_facebook_cookies
       @facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
     
   end

end
