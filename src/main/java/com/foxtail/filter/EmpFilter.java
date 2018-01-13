package com.foxtail.filter;

import javax.xml.crypto.Data;

import com.foxtail.common.util.DateUtils;

public class EmpFilter {

	String kw;
	String deptid;
	String placeid;
	
	
	
	Integer month;
	Long monthFirst;
	Long monthLast;
	
	
	public String getKw() {
		return kw;
	}
	public void setKw(String kw) {
		this.kw = kw;
	}
	public String getDeptid() {
		return deptid;
	}
	public void setDeptid(String deptid) {
		this.deptid = deptid;
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
	
	
	
}
