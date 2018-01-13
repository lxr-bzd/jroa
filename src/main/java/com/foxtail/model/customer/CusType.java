package com.foxtail.model.customer;

public class CusType {
	String id;
	String name;//varchar(50)	 '名称'
	String state;//int(2)	 '是否有效 0：有效，1：无效'
	
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
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	
}
