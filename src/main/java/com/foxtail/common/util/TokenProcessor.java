package com.foxtail.common.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import sun.misc.BASE64Encoder;

/**
* Description:单例模式令牌类 
* @ClassName: TokenProcessor 
 */
public class TokenProcessor {

	private static final TokenProcessor instance=new TokenProcessor();
	
	private TokenProcessor(){
		
	}
	public static TokenProcessor getInstance(){
		return instance;
	}

	/**
	 * 
	* Description:生成令牌    
	* @Title: generateToken  
	 */
	public String generateToken(){
		String token = System.currentTimeMillis()+new Random().nextInt()+"";
		try {
			MessageDigest md = MessageDigest.getInstance("md5");
			byte[] md5 = md.digest(token.getBytes());
			//base64编码
			BASE64Encoder encoder = new BASE64Encoder();
			
			return encoder.encode(md5);
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}
	}
	
}
