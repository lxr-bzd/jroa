package com.foxtail.model.project;

public class PrjMeb {

	String id;//int(11)	 'id'
	String role;//varchar(50)	 '角色名'
	String empid;//int(11)	 '成员id'
	String prjid;//int(11)	 '项目id'
	Long starttime;//bigint(20)	 '任务完成开始时间'
	Long endtime;//bigint(20)	 '任务完成结束时间'
	Long intime;//bigint(20)	 '开始时间'
	Double usetime = 0.0;//double	 '已用时（单位：天）'
	Double alltime;//double	 
	Integer sort;
	String empName;
	String sal_base;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
	}
	public String getPrjid() {
		return prjid;
	}
	public void setPrjid(String prjid) {
		this.prjid = prjid;
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
	public Long getIntime() {
		return intime;
	}
	public void setIntime(Long intime) {
		this.intime = intime;
	}
	public Double getUsetime() {
		return usetime;
	}
	public void setUsetime(Double usetime) {
		this.usetime = usetime;
	}
	public Double getAlltime() {
		return alltime;
	}
	public void setAlltime(Double alltime) {
		this.alltime = alltime;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getSal_base() {
		return sal_base;
	}
	public void setSal_base(String sal_base) {
		this.sal_base = sal_base;
	}

	
	
}
