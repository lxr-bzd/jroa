package com.foxtail.service;

import org.springframework.stereotype.Service;

import com.foxtail.bean.ServiceManager;
import com.foxtail.core.shiro.ShiroUser;

@Service
public class SecurityService {
	
	
	public String getUid() {
		
		
		String id=  ServiceManager.jdbcTemplate.queryForObject("select id from man_emp where account=?", String.class, ShiroUser.getUser().getAccount());
		
		
		return id;

	}
	
	

}
