package com.foxtail.common.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
* Description:BASE64 工具转换类
* @ClassName: BASE64Util 
 */
public class BASE64Util {
	
	/**
	* Description:根据文件路径转换为64位编码    
	* @Title: encodeFromFilePath  
	 */
	public static String encodeFromFilePath(String filePath){
		InputStream in=null;
		byte[] data=null;
		String encode=null;
		try {
			in = new FileInputStream(filePath);
			data = new byte[in.available()];
			in.read(data);
			in.close();
			encode=encodeFromBytes(data);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return encode;
	}
	
	/**
	* Description:根据字节数组转换为64位编码    
	* @Title: encodeFromBytes  
	 */
	public static String encodeFromBytes(byte[] bytes){
		String encode=null;
		try {
			BASE64Encoder encoder = new BASE64Encoder();
			encode = encoder.encode(bytes);// 返回Base64编码过的字节数组字符串
		} catch (Exception e) {
			e.printStackTrace();
		}
		return encode;
	}
	
	/**
	* Description:根据字符串64位解码    
	* @Title: decodeFrom64String  
	 */
	public static void decodeFrom64String(String base64Code, String targetPath) throws Exception {
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] buffer = decoder.decodeBuffer(base64Code);
		FileOutputStream out = new FileOutputStream(targetPath);
		out.write(buffer);
		out.close();
	}
	
	
}
