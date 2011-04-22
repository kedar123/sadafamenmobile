xml = xml_override

 xml.user do
    xml.ur_id users.id
    xml.ur_login users.login
    xml.ur_email users.email
    
    if users.binary_data.blank?
    	xml.ur_image_url "http://#{host_with_port}/images/blank.jpeg"
    else
      xml.ur_image_url "http://#{host_with_port}/users/code_image/#{users.id}"
    end  
    
 end

