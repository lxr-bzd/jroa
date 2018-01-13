package com.foxtail.common.util;

import javax.servlet.http.HttpServletRequest;

/**
 * tcp/ip 工具类
* Description: 
* @ClassName: TcpipUtil 

 */
public class TcpipUtil {

	/**
	* Description:获得ip地址
	* @Title: getIpAddr  
	 */
	  public static String getIpAddr(HttpServletRequest request)
	  {
	    String ip = request.getHeader("x-forwarded-for");
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getHeader("Proxy-Client-IP");
	    }
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if ((ip == null) || (ip.length() == 0) || ("unknown".equalsIgnoreCase(ip))) {
	      ip = request.getRemoteAddr();
	    }
	    return ip;
	  }
	  
	 /**
	 * Description:获得mac地址
	 * @Title: getMacIp  
	  */
	  public static String getMacIp(String sip) throws Exception{
		  String smac = "";
		  UdpGetClientMacAddr umac = new UdpGetClientMacAddr(sip);
		  smac = umac.GetRemoteMacAddr();
		  return smac;
	  }
}
