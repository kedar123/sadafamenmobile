xml.instruct!
  xml.friendlist do 
    render :partial => 'get_friend_list', :collection => @user.friends, :as => :friends, :locals => {:xml_override => xml,:host_with_port => @my_host_and_port}
  end 

