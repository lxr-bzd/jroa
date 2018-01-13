package com.foxtail.model.sys;

import java.util.Date;
import java.io.Serializable;

public class SysReleaseUser implements Serializable{

	private static final long serialVersionUID = 1L;
	
	/**
	 * 普通发布方
	 */
	public static final Integer TYPE_COMMON=Integer.valueOf(1);
	/**
	 * 高级发布方
	 */
	public static final Integer TYPE_SUPER=Integer.valueOf(2);
	
	/**
	 * 无权限发布方
	 */
	public static final Integer TYPE_LIMIT=Integer.valueOf(3);
	
	/**
	 * 组织类型_社会组织
	 */
	public static final Integer ORG_TYPE_COMMUNITY=Integer.valueOf(1);
	/**
	 * 组织类型_志愿服务组织
	 */
	public static final Integer ORG_TYPE_VOLUNTEERING=Integer.valueOf(2);
	/**
	 * 组织类型_共青团组织
	 */
	public static final Integer ORG_TYPE_YOUTH=Integer.valueOf(3);
	/**
	 * 组织类型_其他
	 */
	public static final Integer ORG_TYPE_OTHER=Integer.valueOf(4);
	
	

 	/**
 	* 主键
 	*/
   	private Integer id;
 	/**
 	* 用户id
 	*/
   	private Integer userId;
 	/**
 	* 发布方类型(1-普通发布方,2-高级发布方,3-无权限发布方)
 	*/
   	private Integer releaseType;
 	/**
 	* QQ号码
 	*/
   	private String qq;
 	/**
 	* 图像地址
 	*/
   	private String imgFilePath;
 	/**
 	* 联系人
 	*/
   	private String contactsUser;
 	/**
 	* 联系手机号码
 	*/
   	private String contactsPhone;
 	/**
 	* 所在地址
 	*/
   	private String address;
 	/**
 	* 主办方简介
 	*/
   	private String introduce;
 	/**
 	* 常用地址
 	*/
   	private String commonAddress;
   	
   	/**
   	 * 组织类型
   	 */
   	private Integer orgType;
   	


   	public void setId(Integer id){
   		this.id = id;
   	}

   	public Integer getId(){
		return id;
	}

   	public void setUserId(Integer userId){
   		this.userId = userId;
   	}

   	public Integer getUserId(){
		return userId;
	}

   	public void setReleaseType(Integer releaseType){
   		this.releaseType = releaseType;
   	}

   	public Integer getReleaseType(){
		return releaseType;
	}

   	public void setQq(String qq){
   		this.qq = qq;
   	}

   	public String getQq(){
		return qq;
	}

   	public void setImgFilePath(String imgFilePath){
   		this.imgFilePath = imgFilePath;
   	}

   	public String getImgFilePath(){
		return imgFilePath;
	}

   	public void setContactsUser(String contactsUser){
   		this.contactsUser = contactsUser;
   	}

   	public String getContactsUser(){
		return contactsUser;
	}

   	public void setContactsPhone(String contactsPhone){
   		this.contactsPhone = contactsPhone;
   	}

   	public String getContactsPhone(){
		return contactsPhone;
	}

   	public void setAddress(String address){
   		this.address = address;
   	}

   	public String getAddress(){
		return address;
	}

   	public void setIntroduce(String introduce){
   		this.introduce = introduce;
   	}

   	public String getIntroduce(){
		return introduce;
	}

   	public void setCommonAddress(String commonAddress){
   		this.commonAddress = commonAddress;
   	}

   	public String getCommonAddress(){
		return commonAddress;
	}

	public Integer getOrgType() {
		return orgType;
	}

	public void setOrgType(Integer orgType) {
		this.orgType = orgType;
	}
}

