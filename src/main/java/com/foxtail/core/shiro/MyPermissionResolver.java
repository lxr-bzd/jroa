package com.foxtail.core.shiro;

import org.apache.shiro.authz.Permission;
import org.apache.shiro.authz.permission.PermissionResolver;

public class MyPermissionResolver implements PermissionResolver{

	@Override
	public Permission resolvePermission(String permStr) {
		
		return Myprem.getMyprem(permStr);
		
	}

}
