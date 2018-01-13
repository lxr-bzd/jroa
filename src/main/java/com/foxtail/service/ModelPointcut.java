package com.foxtail.service;

import org.aspectj.lang.JoinPoint;

import com.foxtail.model.BaseModel;
import com.foxtail.model.ModelUtils;
public class ModelPointcut {
	
	
	

	 
    public void doBefore(JoinPoint joinPoint) {  
    	
    	
    	   //String classType = joinPoint.getTarget().getClass().getName();    
           Class<?> clazz = joinPoint.getTarget().getClass();
		/*try {
			clazz = Class.forName(classType);
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} */   
           String clazzName = clazz.getName();    
           String methodName = joinPoint.getSignature().getName(); //获取方法名称   
           Object[] args = joinPoint.getArgs();//参数  
           
           for (Object p : args) {
			if(p instanceof BaseModel)
				if(methodName.equals("save"))
				ModelUtils.finishSaveModel((BaseModel) p);
				else ModelUtils.finishUpdateModel((BaseModel) p);
           
           }
           
           
    }  
	
}
