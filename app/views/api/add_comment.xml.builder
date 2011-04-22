xml.instruct!
  xml.comments do 
      if @commenterror.blank?
         xml.message "Your Comment Is Get Added"
      else  
         xml.message @commenterror
      end  

  end 

