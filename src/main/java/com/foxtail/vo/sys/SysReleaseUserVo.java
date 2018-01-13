package com.foxtail.vo.sys;

import com.foxtail.model.sys.SysReleaseUser;
import com.foxtail.model.sys.SysUser;

public class SysReleaseUserVo extends SysReleaseUser {

	private static final long serialVersionUID = 1L;
	
    public static final String ALIAS_ID = "主键";
    public static final String ALIAS_USER_ID = "用户id";
    public static final String ALIAS_RELEASE_TYPE = "发布方类型(1-普通发布方,2-高级发布方,3-无权限发布方)";
    public static final String ALIAS_QQ = "QQ号码";
    public static final String ALIAS_IMG_FILE_PATH = "图像地址";
    public static final String ALIAS_CONTACTS_USER = "联系人";
    public static final String ALIAS_CONTACTS_PHONE = "联系手机号码";
    public static final String ALIAS_ADDRESS = "所在地址";
    public static final String ALIAS_INTRODUCE = "主办方简介";
    public static final String ALIAS_COMMON_ADDRESS = "常用地址";

    private  SysUser sysUser;
    
	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}
	
}
