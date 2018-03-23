package com.foxtail.model.project;

public class PrjCollect {

	String id;//int(11)	 'id'
	String empid;//int(11)	 '操作人id'
	String empName;//int(11)	 '操作人id'
	String prjid;//int(11)	 '项目id'
	String prjName;
	Double money;//decimal(10,2)	 '收款'
	Long time;//bigint(20)	 '收款时间' 
	String remark;//varchar(200)
	
	String cusName;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
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
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Long getTime() {
		return time;
	}
	public void setTime(Long time) {
		this.time = time;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getCusName() {
		return cusName;
	}
	public void setCusName(String cusName) {
		this.cusName = cusName;
	}
	
	
}
