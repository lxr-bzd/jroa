package com.foxtail.model.customer;

public class Visit {

	
	String id;//int(11)	 'id'
	String cusid;//int(11)	 '客户id'
	String empid;//int(11)	 '业务员id'
	String info;//int(11)	 '回访详情'
	String time;//bigint(20)	 '回访时间'
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
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	
	
}
