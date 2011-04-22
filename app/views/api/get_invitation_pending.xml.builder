xml.instruct!
  xml.invitation_pending do 
    if @pending_invited_by.blank?
      xml.notice "There Is No Invitation Pending Remain"
    else  
    render :partial => 'get_invitation_pending', :collection => @pending_invited_by, :as => :invpending, :locals => {:xml_override => xml,:host_with_port => @my_host_and_port}
    end  
    
  end 

