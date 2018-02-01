package com.foxtail.filter;


public class EmpFilter {

	String kw;
	String[] deptids;
	String placeid;
	
	Long regStart;
	Long regEnd;
	
	
	Integer month;
	
	Integer sex;
	
	String placeKw;
	
	public String getKw() {
		return kw;
	}
	public void setKw(String kw) {
		this.kw = kw;
	}
	
	
	public String[] getDeptids() {
		return deptids;
	}
	public void setDeptids(String[] deptids) {
		this.deptids = deptids;
	}
	public String getPlaceid() {
		return placeid;
	}
	public void setPlaceid(String placeid) {
		this.placeid = placeid;
	}
	
	

	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public Long getRegStart() {
		return regStart;
	}
	public void setRegStart(Long regStart) {
		this.regStart = regStart;
	}
	public Long getRegEnd() {
		return regEnd;
	}
	public void setRegEnd(Long regEnd) {
		this.regEnd = regEnd;
	}
	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}
	public String getPlaceKw() {
		return placeKw;
	}
	public void setPlaceKw(String placeKw) {
		this.placeKw = placeKw;
	}
	
	
	
}
