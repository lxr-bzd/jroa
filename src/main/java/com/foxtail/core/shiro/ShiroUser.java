package com.foxtail.core.shiro;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;

import com.foxtail.vo.sys.SysUserActiveVo;


/**
 * 获取shiro登录的用户身份信息
* Description: 
* @ClassName: ShiroUser 
 */
public class ShiroUser {
	/**
	 * 超级管理员
	 */
	public static final Integer ROLE_TYPE_SUPER_ADMIN = 1;
	/**
	 * 管理员
	 */
	public static final Integer ROLE_TYPE_ADMIN = 2;
	/**
	 * 发布方
	 */
	public static final Integer ROLE_TYPE_PUBLISHER = 3;
	/**
	 * 普通会员
	 */
	public static final Integer ROLE_TYPE_MEMBER = 4;
	
	/**
	* Description:获取当前登录的用户信息    
	* @Title: getUser  
	 */
    public static SysUserActiveVo getUser(){
    	Subject subject = SecurityUtils.getSubject();
    	SysUserActiveVo user = (SysUserActiveVo) subject.getPrincipal();
    	return user;
    }

    /**
    * Description:获取当前登录的用户ID    
    * @Title: getUserId  
     */
    public static Integer getUserId(){
    	Subject subject = SecurityUtils.getSubject();
    	SysUserActiveVo user = (SysUserActiveVo) subject.getPrincipal();
    	if(null != user){
    		return user.getId();
    	}
    	return null;
    }
    
    /**
    * Description:获取角色类型
    * @Title: getRoleType  

     */
    public static Integer getRoleType(){
    	Integer roleType = 4;
    	Subject subject = SecurityUtils.getSubject();
    	if(subject.hasRole("1")){
    		return ROLE_TYPE_SUPER_ADMIN; //系统级角色
    	}
    	if(subject.hasRole("2")){
    		return ROLE_TYPE_ADMIN; //管理员角色
    	}
    	if(subject.hasRole("3")){
    		return ROLE_TYPE_PUBLISHER; //发布方角色
    	}
    	if(subject.hasRole("4")){
    		return ROLE_TYPE_MEMBER; //普通会员角色
    	}
    	return roleType;
    }
    
    /**
    * Description:获取是否是超级管理员的角色    
    * @Title: isTypeAdmin  
     */
    public static boolean isTypeAdmin(){
    	boolean flag=false;
    	Subject subject = SecurityUtils.getSubject();
    	if(subject.hasRole("0")){
    		flag=true;
    	}
    	return flag;
    }
}
