xml.instruct!
xml.profile do
 xml.user do
 
    xml.pr_id current_user.id
    xml.pr_login current_user.login
    xml.ur_email current_user.email
    if current_user.binary_data.blank?
    	xml.ur_image_url "http://#{@host_with_port}/images/blank.jpeg"
    else
      xml.ur_image_url "http://#{@host_with_port}/users/code_image/#{current_user.id}"
    end  
 
 end

end