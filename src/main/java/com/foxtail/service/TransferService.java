package com.foxtail.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foxtail.model.sys.SysUser;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.service.sys.SysUserRoleService;
import com.foxtail.service.sys.SysUserService;


/**用于链接系统账号服务
 * 
 * @author Administrator
 *
 */
@Service
public class TransferService {

	@Autowired
	SysUserService sysUserService;
	
	@Autowired
	SysUserRoleService sysUserRoleService;
	
	public void updateAccount(SysUser sysUser,String roleid) {	
     SysUser user = sysUserService.findSingleUser(sysUser.getAccount());
		
		if(user==null) 
			createAccount(sysUser, roleid);
		else {
			sysUserService.updateByAccount(sysUser);
			SysUserRole sysUserRole = new SysUserRole();
			sysUserRole.setRoleId(Integer.parseInt(roleid));
			sysUserRole.setUserId(user.getId());
			sysUserService.setUserRole(new SysUserRole[] {sysUserRole});
		}
			
	}
	
	
	public void createAccount(SysUser sysUser,String roleid) {
		
		sysUserService.insert(sysUser);
		
		SysUserRole userRole = new SysUserRole();
		userRole.setRoleId(Integer.parseInt(roleid));
		userRole.setUserId(sysUser.getId());
		sysUserRoleService.insert(userRole);

	}
	
	
	
}
