xml.instruct!

xml.user do
  xml.password do
	if  @password_changed
	     xml.message "Password is changed"
	 else
	 xml.message "Password  Could Not Be Changed"
	end	
  end	
end


