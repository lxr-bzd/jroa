package com.foxtail.core.interceptor;

import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import com.foxtail.bean.ServiceManager;

public class HttpLogInterceptor extends HandlerInterceptorAdapter{
	
	
	@Autowired
	ServiceManager serviceManager;
	
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private ThreadLocal<Long> threadTime = new ThreadLocal<>();

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 获取输入参数
		//Map inputParamMap = request.getParameterMap();

		// 获取请求地址
		String schemem = request.getScheme();
		String serverName = request.getServerName();
		int serverPort = request.getServerPort();
		String requestPath = request.getRequestURI();
		String targetUrl = schemem + "://" + serverName + ":" + serverPort + requestPath;

		String queryStr = request.getQueryString();
		if (StringUtils.isNotBlank(queryStr)) {  
			targetUrl = targetUrl + "?" + queryStr;
		}
		logger.info("start-["+request.getRemoteAddr()+"] url:" + targetUrl);
		long l1 = System.currentTimeMillis();
		threadTime.set(l1);
		return super.preHandle(request, response, handler);
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// 获取输入参数
		//Map inputParamMap = request.getParameterMap();

		// 获取请求地址
		String schemem = request.getScheme();
		String serverName = request.getServerName();
		int serverPort = request.getServerPort();
		String requestPath = request.getRequestURI();
		String targetUrl = schemem + "://" + serverName + ":" + serverPort + requestPath;

		String queryStr = request.getQueryString();
		if (StringUtils.isNotBlank(queryStr)) {
			targetUrl = targetUrl + "?" + queryStr;
		}
		long l1 = threadTime.get();
		logger.info("end, cost["+(System.currentTimeMillis() -l1)+"ms] url:" + targetUrl);
		super.afterCompletion(request, response, handler, ex);
	}

	
	
	  public static String getIp2(HttpServletRequest request) {
		            String ip = request.getHeader("X-Forwarded-For");
		            if(StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
		                //多次反向代理后会有多个ip值，第一个ip才是真实ip
		                int index = ip.indexOf(",");
		                if(index != -1){
		                    return ip.substring(0,index);
		                }else{
		                    return ip;
		                }
		            }
		            ip = request.getHeader("X-Real-IP");
		            if(StringUtils.isNotEmpty(ip) && !"unKnown".equalsIgnoreCase(ip)){
		                return ip;
		            }
		            return request.getRemoteAddr();
		        }
	
}
