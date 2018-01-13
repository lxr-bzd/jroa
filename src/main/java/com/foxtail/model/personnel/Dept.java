package com.foxtail.model.personnel;

import com.foxtail.model.BaseModel;

public class Dept extends BaseModel{

	Integer id;
	
	String name;
	
	Integer parentid;
	
	String parentName;
	
	String manNum;
	
	Integer state;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getParentid() {
		return parentid;
	}

	public void setParentid(Integer parentid) {
		this.parentid = parentid;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getManNum() {
		return manNum;
	}

	public void setManNum(String manNum) {
		this.manNum = manNum;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	
	
	
}
