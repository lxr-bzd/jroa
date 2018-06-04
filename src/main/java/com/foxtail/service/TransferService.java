package com.foxtail.service;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foxtail.model.personnel.Emp;
import com.foxtail.model.personnel.Place;
import com.foxtail.model.sys.SysUser;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.service.personnel.PlaceService;
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
	
	@Autowired
	PlaceService placeService;
	
	
	/**
	 * 
	 * @param emp 修改emp
	 * @param pEmp 原来未修改的emp
	 */
	public void updateAccountByEmp(Emp emp,Emp pEmp) {	
		
		
		Place place = placeService.getById(emp.getPlaceid());
		String roleid = place.getRoleid();
		if(StringUtils.isEmpty(emp.getAccount())){
			if(!StringUtils.isEmpty(pEmp.getAccount()))
				//新账号为空旧账号不为空
				sysUserService.deleteByAccouts(new String[]{pEmp.getAccount()});
			
			
		}else {
			
			
			if(!StringUtils.isEmpty(pEmp.getAccount())) {
				//新账号不为空旧账号不为空
				 SysUser user = sysUserService.findSingleUser(pEmp.getAccount());
					user.setUserName(emp.getName());
					user.setAccount(emp.getAccount());
					user.setPassword(emp.getPwd());
					user.setStatus(Integer.parseInt(emp.getState()));
					updateAccount(user, roleid);
					
			}else {
				//新账号不为空旧账号为空
				SysUser sysUser = new SysUser();
				sysUser.setUserName(emp.getName());
				sysUser.setAccount(emp.getAccount());
				sysUser.setPassword(emp.getPwd());
				sysUser.setStatus(Integer.parseInt(emp.getState()));
				createAccount(sysUser, roleid);
				
			}
			
			
		}
		
		
		}
	
	
	public void updateAccount(SysUser sysUser,String roleid) {
		sysUserService.updateByPrimaryKey(sysUser);

		if(roleid!=null) {
		SysUserRole sysUserRole = new SysUserRole();
		sysUserRole.setRoleId(Integer.parseInt(roleid));
		sysUserRole.setUserId(sysUser.getId());
		sysUserService.setUserRole(new SysUserRole[] {sysUserRole});
		}
	}
	
	
	public void updateAccount(Emp emp) {
		SysUser sysUser = new SysUser();
		sysUser.setAccount(emp.getAccount());
		sysUser.setPassword(emp.getPwd());
		
		sysUserService.updateByAccount(sysUser);
		
	}
	
	
	
	public void createAccount(SysUser sysUser,String roleid) {
		
		sysUserService.insert(sysUser);
		
		SysUserRole userRole = new SysUserRole();
		userRole.setRoleId(Integer.parseInt(roleid));
		userRole.setUserId(sysUser.getId());
		sysUserRoleService.insert(userRole);
		

	}
	
	
	
}
