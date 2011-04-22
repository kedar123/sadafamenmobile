xml.instruct!
xml.users do
  render :partial => 'testuser', :collection => @user, :as => :user, :locals => {:xml_override => xml}
end
