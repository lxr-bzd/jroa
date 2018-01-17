package com.foxtail.filter;

import javax.xml.crypto.Data;

import com.foxtail.common.util.DateUtils;

public class EmpFilter {

	String kw;
	String[] deptids;
	String placeid;
	
	Long regStart;
	Long regEnd;
	
	Integer month;
	Long monthFirst;
	Long monthLast;
	
	Integer sex;
	
	
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
		setMonthLast(DateUtils.getLastDayOfMonth().getTime());
		setMonthFirst(DateUtils.getFirstDayOfMonth().getTime());
		
	}
	public Long getMonthFirst() {
		return monthFirst;
	}
	public void setMonthFirst(Long monthFirst) {
		this.monthFirst = monthFirst;
	}
	public Long getMonthLast() {
		return monthLast;
	}
	public void setMonthLast(Long monthLast) {
		this.monthLast = monthLast;
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
	
	
	
}
