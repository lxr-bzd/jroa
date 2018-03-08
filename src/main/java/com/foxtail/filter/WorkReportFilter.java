package com.foxtail.filter;

public class WorkReportFilter {
	
	Integer type;
	
	String[] udeptids;
	
	String sysView;
	
	Long startTime;
	Long endTime;
	
	String uid;
	String deptid;
	
	String[] deptids;
	
	
	String kw ;

	public String getKw() {
		return kw;
	}

	public void setKw(String kw) {
		this.kw = kw;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	

	public String[] getUdeptids() {
		return udeptids;
	}

	public void setUdeptids(String[] udeptids) {
		this.udeptids = udeptids;
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

	public String[] getDeptids() {
		return deptids;
	}

	public void setDeptids(String[] deptids) {
		this.deptids = deptids;
	}

	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	

	
	
}
