xml = xml_override

 xml.rejected_friends do
   for frname in rejected_friend
    xml.fr_id frname.id
    xml.fr_login frname.login
    xml.fr_email frname.email
   end 
   for frname in rejected_friend_req
    xml.fr_id frname.user.id
    xml.fr_login frname.user.login
    xml.fr_email frname.user.email
   end 
   
   
 end

