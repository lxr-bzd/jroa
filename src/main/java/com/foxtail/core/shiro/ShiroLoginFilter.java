package com.foxtail.core.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.servlet.AdviceFilter;
import com.foxtail.common.JsonResult;
import net.sf.json.JSONObject;


public class ShiroLoginFilter extends AdviceFilter {

    /**
     * 在访问controller前判断是否登录，返回json，不进行重定向。
     * @param request
     * @param response
     * @return true-继续往下执行，false-该filter过滤器已经处理，不继续执行其他过滤器
     * @throws Exception
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;
        //System.out.println(httpServletRequest.getRequestURI());
        Subject subject = SecurityUtils.getSubject();
		
            String requestedWith = httpServletRequest.getHeader("X-Requested-With");
            if ((subject==null||!subject.isAuthenticated())&&StringUtils.isNotEmpty(requestedWith) && StringUtils.equals(requestedWith, "XMLHttpRequest")) {//如果是ajax返回指定数据
                
                httpServletResponse.setCharacterEncoding("UTF-8");
                httpServletResponse.setContentType("application/json");
                httpServletResponse.getWriter().write(JSONObject.fromObject(JsonResult.getResult(JsonResult.STATUS_UN_AUTH)).toString());
                return false;
            } else {
            	
                return true;
                
            }
            
            
        
    }

   

}