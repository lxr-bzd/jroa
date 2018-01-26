package com.foxtail.model.project;

import org.apache.xmlgraphics.java2d.StrokingTextHandler;

public class Project {

	String id;//int(11)	 'id'
	String name;//varchar(50)	 '名称'
	Integer productid;
	String productName;
	String customrid;//int(11)	 '客户id'
	String customrName;
	String starttime;//bigint(20)	 '开始时间'
	String endtime;//bigint(20)	 '结束时间'
	String managerid;//int(11)	 '项目经理id'
	String managerName;
	Integer pro_state;//int(2)	 '项目状态 1：正常，2：紧急'
	String receivable;//decimal(10,2)	 '应收帐款'
	String received;//decimal(10,2)	 '已收帐款'
	String uncollected;//decimal(10,2)	 '尾款'
	String salesmanid;
	String salesmanName;
	Long ordertime;//bigint(20)
	Long signtime;
	Integer state;
	Integer progress;
	String member;
	
	String remark;
	String orderempid;//下单人id
	String orderempName;
	
	
	String[] productids;
	
	
	String renew;
	Long renewtime;
	String renew_content;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getProductid() {
		return productid;
	}
	public void setProductid(Integer productid) {
		this.productid = productid;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getCustomrid() {
		return customrid;
	}
	public void setCustomrid(String customrid) {
		this.customrid = customrid;
	}
	public String getCustomrName() {
		return customrName;
	}
	public void setCustomrName(String customrName) {
		this.customrName = customrName;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getManagerid() {
		return managerid;
	}
	public void setManagerid(String managerid) {
		this.managerid = managerid;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public Integer getPro_state() {
		return pro_state;
	}
	public void setPro_state(Integer pro_state) {
		this.pro_state = pro_state;
	}
	public String getReceivable() {
		return receivable;
	}
	public void setReceivable(String receivable) {
		this.receivable = receivable;
	}
	public String getReceived() {
		return received;
	}
	public void setReceived(String received) {
		this.received = received;
	}
	public String getUncollected() {
		return uncollected;
	}
	public void setUncollected(String uncollected) {
		this.uncollected = uncollected;
	}

	
	public String getSalesmanid() {
		return salesmanid;
	}
	public void setSalesmanid(String salesmanid) {
		this.salesmanid = salesmanid;
	}
	public String getSalesmanName() {
		return salesmanName;
	}
	public void setSalesmanName(String salesmanName) {
		this.salesmanName = salesmanName;
	}
	public Long getOrdertime() {
		return ordertime;
	}
	public void setOrdertime(Long ordertime) {
		this.ordertime = ordertime;
	}
	public Long getSigntime() {
		return signtime;
	}
	public void setSigntime(Long signtime) {
		this.signtime = signtime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getProgress() {
		return progress;
	}
	public void setProgress(Integer progress) {
		this.progress = progress;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getMember() {
		return member;
	}
	public void setMember(String member) {
		this.member = member;
	}
	public String getOrderempid() {
		return orderempid;
	}
	public void setOrderempid(String orderempid) {
		this.orderempid = orderempid;
	}
	public String getOrderempName() {
		return orderempName;
	}
	public void setOrderempName(String orderempName) {
		this.orderempName = orderempName;
	}
	public String[] getProductids() {
		return productids;
	}
	public void setProductids(String[] productids) {
		this.productids = productids;
	}
	public String getRenew() {
		return renew;
	}
	public void setRenew(String renew) {
		this.renew = renew;
	}
	public Long getRenewtime() {
		return renewtime;
	}
	public void setRenewtime(Long renewtime) {
		this.renewtime = renewtime;
	}
	public String getRenew_content() {
		return renew_content;
	}
	public void setRenew_content(String renew_content) {
		this.renew_content = renew_content;
	}
	
	
	
}
