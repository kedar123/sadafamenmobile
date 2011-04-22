xml.instruct!
xml.users{
xml.user{
  if @user.errors.blank?
      xml.message "user is created"
  else    
     xml.message @user.errors.full_messages
  end  
}
}

