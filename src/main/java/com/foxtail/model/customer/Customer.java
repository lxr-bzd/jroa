package com.foxtail.model.customer;

public class Customer {
	String id;//int(11)	 'id'
	String name;//varchar(50)	 '名称'
	String typeid;//int(2)	 '类型1：重要，2：普通'
	String typeName;
	String follow;//int(2)	 '跟进状态 1：除访，2：意向，3：报价，4：成交，5：搁置'
	Integer productid;//int(11)	 '产品id'
	String productName;
	String worth;//varchar(50)	 '预计销售额'
	String contacts;//varchar(50)	 '联系人'
	String phone;//varchar(50)	 '联系电话'
	String addr;//varchar(50)	 '地址'
	String empid;//int(11)	 '负责人id'
	String empName;
	String deptName;
	String industry;
	String scale;
	String source;
	String state;//int(2)	 '是否有效 0：有效，1：无效'
	Long createtime;
	
	Product[] products;
	
	String[] productids;
	
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
	
	public String getTypeid() {
		return typeid;
	}
	
	
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public void setTypeid(String typeid) {
		this.typeid = typeid;
	}
	public String getFollow() {
		return follow;
	}
	public void setFollow(String follow) {
		this.follow = follow;
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
	public String getWorth() {
		return worth;
	}
	public void setWorth(String worth) {
		this.worth = worth;
	}
	public String getContacts() {
		return contacts;
	}
	public void setContacts(String contacts) {
		this.contacts = contacts;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
	public String getEmpid() {
		return empid;
	}
	public void setEmpid(String empid) {
		this.empid = empid;
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
	
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getScale() {
		return scale;
	}
	public void setScale(String scale) {
		this.scale = scale;
	}
	
	
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public Product[] getProducts() {
		return products;
	}
	public void setProducts(Product[] products) {
		this.products = products;
	}
	public String[] getProductids() {
		return productids;
	}
	public void setProductids(String[] productids) {
		this.productids = productids;
	}
	public Long getCreatetime() {
		return createtime;
	}
	public void setCreatetime(Long createtime) {
		this.createtime = createtime;
	}
	
}
