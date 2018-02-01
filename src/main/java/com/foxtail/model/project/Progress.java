package com.foxtail.model.project;

public class Progress {

	String id;//int(11)	 'id'
	
	String name;//varchar(50)	 '进度名'
	String state;//int(2)	 '状态 0：正常，1：停用'
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
