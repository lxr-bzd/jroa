package com.foxtail.model.personnel;

public class Apply {
	String id;//int(11)	 'id'
	String uid;//int(11)	 '名称'
	String uname;//姓名
	String deptName;
	String placeName;
	String identifier;//工号
	String type;//int(2)	类型1：情假，2：加班，3：外出，4：离职
	String leave_type;//请假类型 1：事假，2：病假，3：婚假，4丧假
	String starttime;//bigint(20)	 '开始时间'
	String endtime;//bigint(20)	 '结束时间'
	Double duration;
	String[] vouchers;
	String info;//varchar(200)	
	Integer state;
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	
	
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getLeave_type() {
		return leave_type;
	}
	public void setLeave_type(String leave_type) {
		this.leave_type = leave_type;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	
	
	public String[] getVouchers() {
		return vouchers;
	}
	public void setVouchers(String[] vouchers) {
		this.vouchers = vouchers;
	}
	public Double getDuration() {
		return duration;
	}
	public void setDuration(Double duration) {
		this.duration = duration;
	}
	
	
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	
	
}
