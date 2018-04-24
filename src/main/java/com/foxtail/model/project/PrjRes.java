package com.foxtail.model.project;

public class PrjRes {

	String id;//int(11)	 'id'
	String cusid;
	String cusName;//varchar(50)	 '客户名称'
	String prjid;
	String prjName;//varchar(50)	 '项目名称'
	String domain;//varchar(50)	 '域名'
	String ftp;//varchar(50)	 'ftp'
	String wx;//varchar(50)	 '微信'
	String alipay;//varchar(50)	 '支付宝'
	String msg;//varchar(50)	 '短信'
	String android;//varchar(50)	 '安卓'
	String ios;//varchar(50)	 '苹果'
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getCusid() {
		return cusid;
	}
	public void setCusid(String cusid) {
		this.cusid = cusid;
	}
	public String getCusName() {
		return cusName;
	}
	public void setCusName(String cusName) {
		this.cusName = cusName;
	}
	public String getPrjid() {
		return prjid;
	}
	public void setPrjid(String prjid) {
		this.prjid = prjid;
	}
	public String getPrjName() {
		return prjName;
	}
	public void setPrjName(String prjName) {
		this.prjName = prjName;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getFtp() {
		return ftp;
	}
	public void setFtp(String ftp) {
		this.ftp = ftp;
	}
	public String getWx() {
		return wx;
	}
	public void setWx(String wx) {
		this.wx = wx;
	}
	public String getAlipay() {
		return alipay;
	}
	public void setAlipay(String alipay) {
		this.alipay = alipay;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getAndroid() {
		return android;
	}
	public void setAndroid(String android) {
		this.android = android;
	}
	public String getIos() {
		return ios;
	}
	public void setIos(String ios) {
		this.ios = ios;
	}
	
	
	
}
