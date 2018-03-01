package com.foxtail.filter;


public class ApplyFilter {

	Integer applytype;
	
	String sysView;
	
	String uid;
	
	String udeptid;
	
	String[] udeptids;
	
	String[] deptids;
	
	Long starttime;
	Long endtime;
	
	String kw;

	public Integer getApplytype() {
		return applytype;
	}

	public void setApplytype(Integer applytype) {
		this.applytype = applytype;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getSysView() {
		return sysView;
	}

	public void setSysView(String sysView) {
		this.sysView = sysView;
	}

	public String[] getDeptids() {
		return deptids;
	}

	public void setDeptids(String[] deptids) {
		this.deptids = deptids;
	}

	public String getUdeptid() {
		return udeptid;
	}

	public void setUdeptid(String udeptid) {
		this.udeptid = udeptid;
	}

	public String[] getUdeptids() {
		return udeptids;
	}

	public void setUdeptids(String[] udeptids) {
		this.udeptids = udeptids;
	}

	public Long getStarttime() {
		return starttime;
	}

	public void setStarttime(Long starttime) {
		this.starttime = starttime;
	}

	public Long getEndtime() {
		return endtime;
	}

	public void setEndtime(Long endtime) {
		this.endtime = endtime;
	}

	public String getKw() {
		return kw;
	}

	public void setKw(String kw) {
		this.kw = kw;
	}
	
	

}
