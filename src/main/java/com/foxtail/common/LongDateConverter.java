package com.foxtail.common;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.beans.PropertyEditorSupport;  
import org.springframework.stereotype.Component;

import com.foxtail.common.util.StringUtil;
import com.lxr.commons.exception.ApplicationException;

@Component
public class LongDateConverter extends PropertyEditorSupport{

	   @Override
	    public void setAsText(String str) throws IllegalArgumentException {
		   
		   if(str==null||StringUtil.isEmpty(str))
			   return;
    	 try {
       if(str.length()<=10){

    	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
    	   
				Date date = sdf.parse(str);
				setValue( date.getTime());;
       }else {
    	   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");  
    	   
			Date date = sdf.parse(str);
		setValue( date.getTime());;
    	   
       }
       
       
       } catch (ParseException e) {
			
			throw new ApplicationException();
		}
		 
    }
}
