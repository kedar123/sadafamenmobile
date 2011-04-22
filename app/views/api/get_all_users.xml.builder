xml.instruct!
  xml.users do 
    render :partial => 'get_all_users', :collection => @users, :as => :users, :locals => {:xml_override => xml,:host_with_port => @my_host_and_port}
  end 

