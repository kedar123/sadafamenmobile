xml = xml_override

 xml.comments do
   
    xml.id comments.id
    xml.comment comments.comment
    xml.comment_user_name comments.user.login
    xml.comment_time distance_of_time_in_words(Time.now,comments.created_at).to_s + " Before" 
    if comments.user.binary_data.blank?
       xml.comment_image "http://#{host_with_port}/images/blank.jpeg"
    else  
       xml.comment_image "http://#{host_with_port}/users/code_image/#{comments.user.id}"
    end  
   
    
 end

