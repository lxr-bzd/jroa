package com.foxtail.model.admin;

public class ReportDetail {

	String id;//int(11)	 
	String reportid;//int(11)	 '报告id'
	String sort;//int(11)	 '序号'
	String content;//varchar(200)	 '内容'
	String finishdate;//varchar(50)	 '预计完成时间'
	String isfinish;//int(2)	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReportid() {
		return reportid;
	}
	public void setReportid(String reportid) {
		this.reportid = reportid;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFinishdate() {
		return finishdate;
	}
	public void setFinishdate(String finishdate) {
		this.finishdate = finishdate;
	}
	public String getIsfinish() {
		return isfinish;
	}
	public void setIsfinish(String isfinish) {
		this.isfinish = isfinish;
	}
	
	
}
