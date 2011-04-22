xml = xml_override
xml.pending_user do
    xml.pn_us_id invpending.id
    xml.pn_us_login invpending.login
    xml.pn_us_email invpending.email
    if  invpending.binary_data.blank?
    	xml.pn_us_image_url "http://#{host_with_port}/images/blank.jpeg"
    else
    	xml.pn_us_image_url "http://#{host_with_port}/users/code_image/#{invpending.id}"
    end
end 


