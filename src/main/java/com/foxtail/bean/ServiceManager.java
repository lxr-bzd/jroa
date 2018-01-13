package com.foxtail.bean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import com.foxtail.service.SecurityService;
import com.foxtail.service.sys.CommonService;

@Component
public class ServiceManager {

	
	public static CommonService commonService;
	
	public static JdbcTemplate jdbcTemplate;
	
	public static SecurityService securityService;
	
	@Autowired
	public void setCommonService(CommonService commonService) {
		ServiceManager.commonService = commonService;
	}
	
	@Autowired
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		ServiceManager.jdbcTemplate = jdbcTemplate;
	}
	
	@Autowired
	public void setSecurityService(SecurityService securityService) {
		ServiceManager.securityService = securityService;
	}
	
	
	
	
}
