package com.foxtail.model.personnel;

public class Level {
	String id;//int(11)	 'id'
	String name;//varchar(50)	 '等级'
	String subs_meal;//decimal(10,2)	 '餐补'
	String sal_base;//decimal(10,2)	 '底薪'
	String subs_insurance;//decimal(10,2)	 '保险补助'
	String subs_every;//decimal(10,2)	 '全勤'
	String subs_manage;
	String subs_team;
	String subs_age;
	String state;//int(11)	 '0 正常 ，1 停用'
	String remark;//varchar(200)	 '备注'
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
	
	public String getSubs_meal() {
		return subs_meal;
	}
	public void setSubs_meal(String subs_meal) {
		this.subs_meal = subs_meal;
	}
	public String getSal_base() {
		return sal_base;
	}
	public void setSal_base(String sal_base) {
		this.sal_base = sal_base;
	}
	public String getSubs_insurance() {
		return subs_insurance;
	}
	public void setSubs_insurance(String subs_insurance) {
		this.subs_insurance = subs_insurance;
	}
	
	public String getSubs_manage() {
		return subs_manage;
	}
	public void setSubs_manage(String subs_manage) {
		this.subs_manage = subs_manage;
	}
	public String getSubs_team() {
		return subs_team;
	}
	public void setSubs_team(String subs_team) {
		this.subs_team = subs_team;
	}
	public String getSubs_age() {
		return subs_age;
	}
	public void setSubs_age(String subs_age) {
		this.subs_age = subs_age;
	}
	public String getSubs_every() {
		return subs_every;
	}
	public void setSubs_every(String subs_every) {
		this.subs_every = subs_every;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

}
