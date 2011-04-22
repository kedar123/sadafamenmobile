xml = xml_override

 xml.prayer do
   
    xml.id prayers.id
    xml.title prayers.title
    xml.description prayers.description
    if  prayers.lat.blank?
    xml.lat 0.00
    xml.lang 0.00
    else
    xml.lat prayers.lat
    xml.lang prayers.lang
    end
    
    
    if prayers.user.binary_data.blank?
       xml.prayer_image "http://#{host_with_port}/images/blank.jpeg"
    else  
       xml.prayer_image "http://#{host_with_port}/users/code_image/#{prayers.user.id}"
    end  
   
    
 end

