xml.instruct!
  xml.friendlist do 
    render :partial => 'get_rejected_list' ,:locals => {:xml_override => xml,:host_with_port => @my_host_and_port,:rejected_friend=>@rejected_friends,:rejected_friend_req=>@rejected_friends_req}
  end 

