package com.foxtail.service;

import java.util.Collection;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foxtail.bean.ServiceManager;
import com.foxtail.core.shiro.ShiroUser;
import com.foxtail.vo.sys.SysUserActiveVo;

@Service
public class SecurityService {
	
	@Autowired
	SessionDAO sessionDAO;
	
	
	public String getUid() {
		
		
		String id=  ServiceManager.jdbcTemplate.queryForObject("select id from man_emp where account=?", String.class, ShiroUser.getUser().getAccount());
		
		
		return id;

	}
	
	public String getUname() {
		
		
		String id=  ServiceManager.jdbcTemplate.queryForObject("select name from man_emp where account=?", String.class, ShiroUser.getUser().getAccount());
		
		
		return id;

	}
	
	
	public boolean isOnline(String[] ids) {
		
		Collection<Session> sessions = sessionDAO.getActiveSessions();
		
		for (Session session : sessions) {
			Object object = session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
			if(!(object instanceof SimplePrincipalCollection))continue;
			
			SysUserActiveVo activeVo = (SysUserActiveVo)(((SimplePrincipalCollection)object).getPrimaryPrincipal());
			for (String id : ids) {
				if(id.equals(activeVo.getId().toString()))
					return true;
			}
			
		}
		
		return false;

	}
	
	

}
