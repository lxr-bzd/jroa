package com.foxtail.model.admin;

import java.util.Map;

public class WorkReport {

	String id;//int(11)	 'id'
	Integer type;//int(2)	 '报告类型 1：日报，2：周报，3月报'
	String empid;//int(11)	 '职员id'
	String empName;
	String deptName;
	String content;//varchar(1000)	 '内容'
	String study;//varchar(1000)	
	Long createtime;
	Integer report_state;//int(2)	是否有效 1：未审核，2：已审核
	String examineid;
	String examineName;
	String examineInfo;
	Long examinetime;
	
	String uncomplete;//未完成的原因
	String answer;
	ReportDetail[] details;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStudy() {
		return study;
	}
	public void setStudy(String study) {
		this.study = study;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public Long getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Long createtime) {
		this.createtime = createtime;
	}
	public Integer getReport_state() {
		return report_state;
	}
	public void setReport_state(Integer report_state) {
		this.report_state = report_state;
	}
	public String getExamineid() {
		return examineid;
	}
	public void setExamineid(String examineid) {
		this.examineid = examineid;
	}
	public String getExamineName() {
		return examineName;
	}
	public void setExamineName(String examineName) {
		this.examineName = examineName;
	}
	public Long getExaminetime() {
		return examinetime;
	}
	public void setExaminetime(Long examinetime) {
		this.examinetime = examinetime;
	}
	
	public ReportDetail[] getDetails() {
		return details;
	}
	public void setDetails(ReportDetail[] details) {
		this.details = details;
	}
	public String getUncomplete() {
		return uncomplete;
	}
	public void setUncomplete(String uncomplete) {
		this.uncomplete = uncomplete;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getExamineInfo() {
		return examineInfo;
	}
	public void setExamineInfo(String examineInfo) {
		this.examineInfo = examineInfo;
	}
	
	
	
	
	
}
