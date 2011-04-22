xml.instruct!
  xml.prayers do 
    render :partial => 'comment_list', :collection =>  @prayer.comments, :as => :comments, :locals => {:xml_override => xml,:host_with_port => @my_host_and_port}
  
    
  end 

