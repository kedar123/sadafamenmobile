xml = xml_override

 xml.friend do
    xml.fr_id friends.id
    xml.fr_login friends.login
    xml.fr_email friends.email
    
    if friends.binary_data.blank?
    	xml.fr_image_url "http://#{host_with_port}/images/blank.jpeg"
    else
      xml.fr_image_url "http://#{host_with_port}/users/code_image/#{friends.id}"
    end  
    
 end

