package com.foxtail.model.project;

public class PrjProgress {

	String id;//int(11)	 'id'
	String prjid;//int(11)	 '项目id'
	String info;//varchar(200)	 '详情'
	String time;//bigint(20)	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPrjid() {
		return prjid;
	}
	public void setPrjid(String prjid) {
		this.prjid = prjid;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	
	
	
}
