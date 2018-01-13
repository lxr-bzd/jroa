package com.foxtail.model;

public class BaseModel {
	  String creator;//'创建者',
	  String createtime;//'创建时间',
	  String updatetime;//'版本时间戳',
	  String remark;//'系统备注',
	  String isvalid;//'是否有效 0-无效 1-有效',
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getCreatetime() {
		return createtime;
	}
	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getIsvalid() {
		return isvalid;
	}
	public void setIsvalid(String isvalid) {
		this.isvalid = isvalid;
	}
	  
	  
	  

}
