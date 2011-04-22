class Notifier < ActionMailer::Base
  default :from => 'pragtech.co.in',
          :return_path => 'pragtech.co.in'


  
   def friend_request(recipient,username,my_host_with_port)
     @username = username
     @femail = recipient
     @my_host_with_port = my_host_with_port
     mail(:to => recipient)
   end

   def send_welcome_registration(myuser,my_host_with_port)
       @userlogin =  myuser.login
       @my_host_with_port = my_host_with_port
       mail(:to => myuser.email)
   end  

   def send_reset_code(user,my_host_with_port)
     @user = user
     @my_host_with_port = my_host_with_port
     mail(:to => user.email)
   end      


end
