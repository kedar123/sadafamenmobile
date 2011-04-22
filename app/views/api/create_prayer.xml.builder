xml.instruct!
xml.prayers{
xml.prayer{
  if @prayer_created
      xml.message "prayer is created"
  else    
      xml.message "prayer is not created"
  end  
}
}

