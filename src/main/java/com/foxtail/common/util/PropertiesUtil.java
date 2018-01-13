package com.foxtail.common.util;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Properties;
/**
 * .properties公共调用
 */
public class PropertiesUtil {
	private static String properiesName = "wechat.properties";
	
	public void setProperiesName(String properiesName) {
		this.properiesName = properiesName;
	}
	public PropertiesUtil() {
		this.properiesName = "wechat.properties";
	}
	public PropertiesUtil(String fileName) {
		this.properiesName = fileName;
	}
	public static String readProperty(String key) {
		String value = "";
		InputStream is = null;
		try {
			is = PropertiesUtil.class.getClassLoader().getResourceAsStream(
					properiesName);
			Properties p = new Properties();
			p.load(is);
			value = p.getProperty(key);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return value;
	}
	

	public Properties getProperties() {
		Properties p = new Properties();
		InputStream is = null;
		try {
			is = PropertiesUtil.class.getClassLoader().getResourceAsStream(
					properiesName);
			p.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return p;
	}

	public void writeProperty(String key, String value) {
		InputStream is = null;
		OutputStream os = null;
		Properties p = new Properties();
		try {
			is = new FileInputStream(PropertiesUtil.class.getClassLoader().getResource(properiesName).getFile());
			p.load(is);
			os = new FileOutputStream(PropertiesUtil.class.getClassLoader().getResource(properiesName).getFile());

			p.setProperty(key, value);
			p.store(os, key);
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (null != is)
					is.close();
				if (null != os)
					os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}
	
	public static String getAppid(){
		return readProperty("mp.appid");
	}
	
	public static String getAppsecret(){
		return readProperty("mp.appsecret");
	}
	
	public static String getPartnerid(){
		return readProperty("mp.partnerid");
	}
	
	public static String getPartnerkey(){
		return readProperty("mp.partnerkey");
	}
	
	public static String getGMXAppid(){
		return readProperty("mp.GMXappid");
	}
	
	public static String getGMXAppsecret(){
		return readProperty("mp.GMXappsecret");
	}

	public static String getGMXPartnerid(){
		return readProperty("mp.GMXpartnerid");
	}
	
	public static String getGMXPartnerkey(){
		return readProperty("mp.GMXpartnerkey");
	}
	public static String getGMXtoken(){
		return readProperty("mp.GMXtoken");
	}
	public static String getGMXaesKey(){
		return readProperty("mp.GMXaesKey");
	}
	public static String getGMXdefaultReply(){
		return readProperty("mp.GMXdefaultReply");
	}
	public static String getNotify_url(){
		return readProperty("mp.notify_url");
	}
	public static String getGMXNotify_url(){
		return readProperty("mp.GMXnotify_url");
	}
	public static String getGMXdomain(){
		return readProperty("GMXdomain");
	}
	public static String getDomain(){
		return readProperty("domain");
	}
	public static String getIncomeTemplateid(){
		return readProperty("mp.incomeTemplateid");
	}
	public static String getPayTemplateid(){
		return readProperty("mp.payTemplateid");
	}
	public static String getDeliveryTemplateid(){
		return readProperty("mp.deliveryTemplateid");
	}
	public static String getGMXIncomeTemplateid(){
		return readProperty("mp.GMXincomeTemplateid");
	}
	public static String getGMXPayTemplateid(){
		return readProperty("mp.GMXpayTemplateid");
	}
	public static String getGMXDeliveryTemplateid(){
		return readProperty("mp.GMXDeliveryTemplateid");
	}
	public static String getGmxPrizeNotifyTemplateid(){
		return readProperty("mp.GMXPrizeNotifyTemplateid");
	}
	public static String getStakeTemplateid(){
		return readProperty("mp.stakeTemplateid");
	}
	
	public static String getXTTAppid(){
		return readProperty("mp.XTTappid");
	}
	
	public static String getXTTAppsecret(){
		return readProperty("mp.XTTappsecret");
	}

	public static String getXTTPartnerid(){
		return readProperty("mp.XTTpartnerid");
	}
	
	public static String getXTTPartnerkey(){
		return readProperty("mp.XTTpartnerkey");
	}
	public static String getXTTtoken(){
		return readProperty("mp.XTTtoken");
	}
	public static String getXTTaesKey(){
		return readProperty("mp.XTTaesKey");
	}
	public static String getXTTdefaultReply(){
		return readProperty("mp.XTTdefaultReply");
	}
	public static String getXTTNotify_url(){
		return readProperty("mp.XTTnotify_url");
	}
	public static String getXTTdomain(){
		return readProperty("XTTdomain");
	}
	/**
	 * 公共调用
	 */
	public static String getPropertiesValueByKey(String key){
		return readProperty(key);
	}

	public static void main(String[] args) {
		/*PropertiesUtil p = new PropertiesUtil("wechat.properties");
		p.writeProperty("appid", "123456");
		System.out.println(p.readProperty("appid"));*/
		
		System.out.println(PropertiesUtil.getPartnerid());
		System.out.println(PropertiesUtil.getPartnerkey());
		System.out.println(PropertiesUtil.getGMXAppid());
		System.out.println(PropertiesUtil.getNotify_url());
		System.out.println(PropertiesUtil.getDomain());
		System.out.println(PropertiesUtil.getIncomeTemplateid());
		System.out.println(PropertiesUtil.getPayTemplateid());
		System.out.println(PropertiesUtil.getGMXdomain());
		System.out.println(PropertiesUtil.getXTTdomain());
		System.out.println(PropertiesUtil.getGMXIncomeTemplateid());
		System.out.println(PropertiesUtil.getGMXPayTemplateid());
	}

}
