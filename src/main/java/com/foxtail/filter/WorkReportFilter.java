package com.foxtail.filter;

public class WorkReportFilter {
	
	Integer type;
	
	String[] deptids;
	
	Long startTime;
	Long endTime;

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String[] getDeptids() {
		return deptids;
	}

	public void setDeptids(String[] deptids) {
		this.deptids = deptids;
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

	
	
}
