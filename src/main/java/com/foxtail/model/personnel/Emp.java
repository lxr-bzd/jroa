package com.foxtail.model.personnel;

public class Emp {

	
	String id;//int(11)	 'id'
	String name;//varchar(50)	 '名称'
	String deptid;//int(11)	 '部门id'
	String deptName;
	String placeid;//int(11)	 '职位id'
	String placeName;
	String levelid;//int(11)	 '等级id'
	String levelName;
	String account;
	String phone;//varchar(11)	 '手机号'
	String identifier;//varchar(50)	 '工号'
	String idcard;//varchar(50)	 '身份证'
	String entry_time;//bigint(20)	 '入职日期'
	String birthday;//bigint(20)	 '生日'
	String sex;//int(2)	 '性别 1：男 2:女'
	String pwd;//varchar(50)	 '密码'
	String contact_addr;//varchar(50)	 '联系地址'
	
	String origin;//varchar(50)	 '籍贯'
	String national;//varchar(50)	 '名族'
	String political;//varchar(50)	 '政治面貌'
	String marriage;//varchar(50)	 '婚姻状况 1已婚，2未婚，3离异 '
	String height;//int(11)	 '升高（cm）'
	String experience;//int(11)	 '从业年限（年）'
	String health;//int(11)	 '健康状况'
	String weight;//int(11)	 '体重（kg）'
	String urgent_man;//varchar(10)	 '紧急联系人'
	String urgent_phone;//varchar(20)	 '紧急联系人电话'
	String reg_area;//varchar(50)	 '户口所在地'
	String live_area;//varchar(50)	 '现在家庭居住地址'
	String graduation_school;//varchar(50)	 'b毕业学校'
	String major;//专业
	Long graduation_time;//bigint(20)	 '毕业时间'
	String education;//varchar(50)	 '学历'
	String certificate;//varchar(50)	 '已有职称或证书'
	
	String state;//int(2)	 '状态'
	String remark;
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
	public String getDeptid() {
		return deptid;
	}
	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}
	public String getPlaceid() {
		return placeid;
	}
	public void setPlaceid(String placeid) {
		this.placeid = placeid;
	}
	public String getLevelid() {
		return levelid;
	}
	public void setLevelid(String levelid) {
		this.levelid = levelid;
	}
	
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public String getIdcard() {
		return idcard;
	}
	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
	public String getEntry_time() {
		return entry_time;
	}
	public void setEntry_time(String entry_time) {
		this.entry_time = entry_time;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getContact_addr() {
		return contact_addr;
	}
	public void setContact_addr(String contact_addr) {
		this.contact_addr = contact_addr;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getLevelName() {
		return levelName;
	}
	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getNational() {
		return national;
	}
	public void setNational(String national) {
		this.national = national;
	}
	public String getPolitical() {
		return political;
	}
	public void setPolitical(String political) {
		this.political = political;
	}
	public String getMarriage() {
		return marriage;
	}
	public void setMarriage(String marriage) {
		this.marriage = marriage;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getExperience() {
		return experience;
	}
	public void setExperience(String experience) {
		this.experience = experience;
	}
	public String getHealth() {
		return health;
	}
	public void setHealth(String health) {
		this.health = health;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getUrgent_man() {
		return urgent_man;
	}
	public void setUrgent_man(String urgent_man) {
		this.urgent_man = urgent_man;
	}
	public String getUrgent_phone() {
		return urgent_phone;
	}
	public void setUrgent_phone(String urgent_phone) {
		this.urgent_phone = urgent_phone;
	}
	public String getReg_area() {
		return reg_area;
	}
	public void setReg_area(String reg_area) {
		this.reg_area = reg_area;
	}
	public String getLive_area() {
		return live_area;
	}
	public void setLive_area(String live_area) {
		this.live_area = live_area;
	}
	public String getGraduation_school() {
		return graduation_school;
	}
	public void setGraduation_school(String graduation_school) {
		this.graduation_school = graduation_school;
	}
	
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	
	public Long getGraduation_time() {
		return graduation_time;
	}
	public void setGraduation_time(Long graduation_time) {
		this.graduation_time = graduation_time;
	}
	public String getEducation() {
		return education;
	}
	public void setEducation(String education) {
		this.education = education;
	}
	public String getCertificate() {
		return certificate;
	}
	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}
	
	
	
	
	
}
