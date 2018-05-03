package com.foxtail.model.project;

import java.util.List;
import java.util.Map;

import org.apache.xmlgraphics.java2d.StrokingTextHandler;

public class Project {

	String id;//int(11)	 'id'
	String name;//varchar(50)	 '名称'
	Integer productid;
	String productName;
	String customrid;//int(11)	 '客户id'
	String customrName;
	String cusPhone;
	String starttime;//bigint(20)	 '开始时间'
	String endtime;//bigint(20)	 '结束时间'
	String managerid;//int(11)	 '项目经理id'
	String managerName;
	Integer pro_state;//int(2)	 '项目状态 1：正常，2：紧急'
	String receivable;//decimal(10,2)	 '应收帐款'
	Double received;//decimal(10,2)	 '已收帐款'
	String uncollected;//decimal(10,2)	 '尾款'
	String salesmanid;
	String salesmanName;
	Long ordertime;//bigint(20)
	Long signtime;
	Integer state;
	Integer progressid;
	String progressName;
	String member;
	String doc;
	
	String remark;
	String orderempid;//下单人id
	String orderempName;
	
	List<Map<String, Object>> products;
	String[] productids;
	
	List<Map<String, Object>> mebs;
	
	
	Double renew;
	Long renewtime;
	String renew_content;
	
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getProductid() {
		return productid;
	}
	public void setProductid(Integer productid) {
		this.productid = productid;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getCustomrid() {
		return customrid;
	}
	public void setCustomrid(String customrid) {
		this.customrid = customrid;
	}
	public String getCustomrName() {
		return customrName;
	}
	public void setCustomrName(String customrName) {
		this.customrName = customrName;
	}
	
	public String getCusPhone() {
		return cusPhone;
	}
	public void setCusPhone(String cusPhone) {
		this.cusPhone = cusPhone;
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
	public String getManagerid() {
		return managerid;
	}
	public void setManagerid(String managerid) {
		this.managerid = managerid;
	}
	public String getManagerName() {
		return managerName;
	}
	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}
	public Integer getPro_state() {
		return pro_state;
	}
	public void setPro_state(Integer pro_state) {
		this.pro_state = pro_state;
	}
	public String getReceivable() {
		return receivable;
	}
	public void setReceivable(String receivable) {
		this.receivable = receivable;
	}
	
	public Double getReceived() {
		return received;
	}
	public void setReceived(Double received) {
		this.received = received;
	}
	public String getUncollected() {
		return uncollected;
	}
	public void setUncollected(String uncollected) {
		this.uncollected = uncollected;
	}
	
	public String getSalesmanid() {
		return salesmanid;
	}
	public void setSalesmanid(String salesmanid) {
		this.salesmanid = salesmanid;
	}
	public String getSalesmanName() {
		return salesmanName;
	}
	public void setSalesmanName(String salesmanName) {
		this.salesmanName = salesmanName;
	}
	public Long getOrdertime() {
		return ordertime;
	}
	public void setOrdertime(Long ordertime) {
		this.ordertime = ordertime;
	}
	public Long getSigntime() {
		return signtime;
	}
	public void setSigntime(Long signtime) {
		this.signtime = signtime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	
	public Integer getProgressid() {
		return progressid;
	}
	public void setProgressid(Integer progressid) {
		this.progressid = progressid;
	}
	
	
	public String getProgressName() {
		return progressName;
	}
	public void setProgressName(String progressName) {
		this.progressName = progressName;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	public String getMember() {
		return member;
	}
	public void setMember(String member) {
		this.member = member;
	}
	public String getOrderempid() {
		return orderempid;
	}
	public void setOrderempid(String orderempid) {
		this.orderempid = orderempid;
	}
	public String getOrderempName() {
		return orderempName;
	}
	public void setOrderempName(String orderempName) {
		this.orderempName = orderempName;
	}
	public String[] getProductids() {
		return productids;
	}
	public void setProductids(String[] productids) {
		this.productids = productids;
	}

	public Double getRenew() {
		return renew;
	}
	public void setRenew(Double renew) {
		this.renew = renew;
	}
	public Long getRenewtime() {
		return renewtime;
	}
	public void setRenewtime(Long renewtime) {
		this.renewtime = renewtime;
	}
	public String getRenew_content() {
		return renew_content;
	}
	public void setRenew_content(String renew_content) {
		this.renew_content = renew_content;
	}
	public List<Map<String, Object>> getProducts() {
		return products;
	}
	public void setProducts(List<Map<String, Object>> products) {
		this.products = products;
	}
	public List<Map<String, Object>> getMebs() {
		return mebs;
	}
	public void setMebs(List<Map<String, Object>> mebs) {
		this.mebs = mebs;
	}
	public String getDoc() {
		return doc;
	}
	public void setDoc(String doc) {
		this.doc = doc;
	}
	
	
	
	
	
}
