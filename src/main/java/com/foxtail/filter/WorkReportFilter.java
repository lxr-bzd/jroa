package com.foxtail.filter;

public class WorkReportFilter {
	
	Integer type;
	
	String[] deptids;
	
	String sysView;
	
	Long startTime;
	Long endTime;
	
	String uid;
	
	String udeptid;

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

	public String getSysView() {
		return sysView;
	}

	public void setSysView(String sysView) {
		this.sysView = sysView;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUdeptid() {
		return udeptid;
	}

	public void setUdeptid(String udeptid) {
		this.udeptid = udeptid;
	}

	
	
}
