xml = xml_override

 xml.prayer do
    xml.id prayers.id
    xml.title prayers.title
    xml.description prayers.description
    xml.comments_count prayers.comments.count
    xml.prayer_time distance_of_time_in_words(Time.now,prayers.created_at).to_s + " Before" 
    if prayers.viewed_no.blank?
       xml.prayer_viewed 0
    else
       xml.prayer_viewed prayers.viewed_no
    end   
    if prayers.prayed_no.blank?
      xml.prayer_prayed 0
    else  
      xml.prayer_prayed prayers.prayed_no  
    end  
    
    
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

