package com.foxtail.common;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.lxr.commons.exception.ApplicationException;

public class SpringFileupload {
	
	
	public static String upload(MultipartFile  file,String rpath) throws IllegalStateException, IOException {
		 if (file.isEmpty()) return null;
	           
	            String fileName=file.getOriginalFilename();// 文件原名称
	            
	            // 判断文件类型
	            fileName = java.net.URLEncoder.encode(fileName,"utf-8").replace("%", "");
	                 
	            
	            File file2  = new File(rpath);
	            
	            String webroot = "upload/news";
	            
	                    String realPath= new File(file2.getParent(),webroot).getPath();
	                    
	                    String trueFileName=String.valueOf(System.currentTimeMillis())+fileName;
	                   
	                    if(!new File(realPath).exists())
	                    	new File(realPath).mkdirs();
	                   
	                    String path=realPath+"/"+trueFileName;
	                   
	                    // 转存文件到指定的路径
	                    file.transferTo(new File(path));
	                  
	               
	            
	                    System.out.println("上传的文件 :"+fileName); 
	       
		return "/"+webroot+"/"+trueFileName;

	}
	
	
	public static String upload(MultipartHttpServletRequest  request,String name) throws IllegalStateException, IOException {
		MultipartHttpServletRequest multipartRequest =  request;         
		// 获得文件：
		MultipartFile knowledge_icon_url = (MultipartFile) multipartRequest.getFile(name); 
	       
		String rpath = request.getSession().getServletContext().getRealPath("/");
		return upload(knowledge_icon_url, rpath);

	}
	
	public static String upload(HttpServletRequest  request,String name) {
		 CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
	       
		  String path = null;
	        // 判断是否有文件上传  
	        if (!commonsMultipartResolver.isMultipart(request))throw new MultipartException("Could not parse multipart servlet request");
	
		
		
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;         
		
	try {
			return upload(multipartRequest, name);
		}  catch (Exception e1) {
			throw new ApplicationException(e1);
		}
			

	}
	
	

}
