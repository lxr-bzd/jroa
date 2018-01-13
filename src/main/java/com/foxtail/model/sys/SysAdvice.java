package com.foxtail.model.sys;

import java.util.Date;
import java.io.Serializable;

public class SysAdvice implements Serializable{

	private static final long serialVersionUID = 1L;

 	/**
 	* 主键
 	*/
   	private Integer id;
 	/**
 	* 创建人id
 	*/
   	private Integer createUserId;
 	/**
 	* 创建人姓名
 	*/
   	private String createUserName;
 	/**
 	* 创建时间
 	*/
   	private java.util.Date createTime;
 	/**
 	* 建议
 	*/
   	private String advice;
 	/**
 	* 回复人id
 	*/
   	private Integer replyUserId;
 	/**
 	* 回复人姓名
 	*/
   	private String replyUserName;
 	/**
 	* 回复时间
 	*/
   	private java.util.Date replyTime;
 	/**
 	* 状态(1默认提交 2回复 3其他操作)
 	*/
   	private Integer status;
 	/**
 	* 回复内容
 	*/
   	private String replyContent;


   	public void setId(Integer id){
   		this.id = id;
   	}

   	public Integer getId(){
		return id;
	}

   	public void setCreateUserId(Integer createUserId){
   		this.createUserId = createUserId;
   	}

   	public Integer getCreateUserId(){
		return createUserId;
	}

   	public void setCreateUserName(String createUserName){
   		this.createUserName = createUserName;
   	}

   	public String getCreateUserName(){
		return createUserName;
	}

   	public void setCreateTime(java.util.Date createTime){
   		this.createTime = createTime;
   	}

   	public java.util.Date getCreateTime(){
		return createTime;
	}

   	public void setAdvice(String advice){
   		this.advice = advice;
   	}

   	public String getAdvice(){
		return advice;
	}

   	public void setReplyUserId(Integer replyUserId){
   		this.replyUserId = replyUserId;
   	}

   	public Integer getReplyUserId(){
		return replyUserId;
	}

   	public void setReplyUserName(String replyUserName){
   		this.replyUserName = replyUserName;
   	}

   	public String getReplyUserName(){
		return replyUserName;
	}

   	public void setReplyTime(java.util.Date replyTime){
   		this.replyTime = replyTime;
   	}

   	public java.util.Date getReplyTime(){
		return replyTime;
	}

   	public void setStatus(Integer status){
   		this.status = status;
   	}

   	public Integer getStatus(){
		return status;
	}

   	public void setReplyContent(String replyContent){
   		this.replyContent = replyContent;
   	}

   	public String getReplyContent(){
		return replyContent;
	}
}

