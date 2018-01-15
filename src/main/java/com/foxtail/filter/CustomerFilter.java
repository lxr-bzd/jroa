package com.foxtail.filter;

import java.util.List;

public class CustomerFilter {

	Integer state;
	
	String kw;
	Long startTime;
	Long endTime;
	
	String[] deptids;
	

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getKw() {
		return kw;
	}

	public void setKw(String kw) {
		this.kw = kw;
	}

	public Long getStartTime() {
		return startTime;
	}

	public void setStartTime(Long startTime) {
		this.startTime = startTime;
	}

	public Long getEndTime() {
		return endTime;
	}

	public void setEndTime(Long endTime) {
		this.endTime = endTime;
	}

	public String[] getDeptids() {
		return deptids;
	}

	public void setDeptids(String[] deptids) {
		this.deptids = deptids;
	}


}
