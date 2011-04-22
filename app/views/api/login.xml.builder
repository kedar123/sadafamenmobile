xml.instruct!
xml.users do

  if !@user.blank?
      xml.user {
      xml.id @user.id
      xml.login @user.login
      }
  else  
  xml.user {
      xml.id 0
      xml.login "unsuccessfull"
      }
  end   
end


