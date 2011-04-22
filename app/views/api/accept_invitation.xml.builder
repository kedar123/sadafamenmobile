xml.instruct!
if params[:user][:accept] == "1"
  xml.message "Friendship is accepted"
else
    xml.message "Friendship is rejected"
end



