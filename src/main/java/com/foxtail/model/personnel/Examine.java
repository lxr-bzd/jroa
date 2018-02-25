package com.foxtail.model.personnel;

public class Examine {

	String id;//int(11)	 'id'
	String applyid;//int(11)	 '申请id'
	String exaid;//int(11)	 '审核人id'
	String exaName;
	String exatime;//bigint(20)	 '审核时间'
	String info;//varchar(200)	 '详情'
	Integer result; //审核结果 1：通过，2：不通过
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getApplyid() {
		return applyid;
	}
	public void setApplyid(String applyid) {
		this.applyid = applyid;
	}
	public String getExaid() {
		return exaid;
	}
	public void setExaid(String exaid) {
		this.exaid = exaid;
	}
	public String getExatime() {
		return exatime;
	}
	public void setExatime(String exatime) {
		this.exatime = exatime;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public Integer getResult() {
		return result;
	}
	public void setResult(Integer result) {
		this.result = result;
	}
	public String getExaName() {
		return exaName;
	}
	public void setExaName(String exaName) {
		this.exaName = exaName;
	}

	
	
	
	
	
}
