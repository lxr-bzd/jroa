package com.foxtail.common;

import java.util.Map;

import org.dom4j.DocumentException;

import com.lxr.commons.utils.XmlUtils;

public class AppContext {


	public static boolean isDebug = true;
	
	
	public static Map<String, String> appConfig = null;
	
	static{
		
			try {
				appConfig = XmlUtils.xml2map(AppContext.class.getResourceAsStream("/appConfig.xml"));
			} catch (DocumentException e) {
				throw new RuntimeException(e);
			}
		
		
	}
	
	public static String getFileHost() {
		
		return appConfig.get("fileHost");

		
		
	}
	
	public static String getProperties(String key) {
		return appConfig.get(key);

	}
}
