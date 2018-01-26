package com.foxtail.core.shiro;

import java.io.Serializable;

import com.lxr.commons.exception.ApplicationException;

public class Myprem implements Serializable{

	String prem;
	String sysModule;
	public String getPrem() {
		return prem;
	}
	public void setPrem(String prem) {
		this.prem = prem;
	}
	public String getSysModule() {
		return sysModule;
	}
	public void setSysModule(String sysModule) {
		this.sysModule = sysModule;
	}
	
	public static Myprem getMyprem(String premStr) {
		try {

			Myprem myprem = new Myprem();
			
			premStr = premStr.trim();
			int i = premStr.indexOf("?");
			if(i!=-1) {
				myprem.setPrem(premStr.substring(0, i));
				
				String[] params = premStr.substring(i+1,premStr.length()).split("&");
				for (int j = 0; j < params.length; j++) {
					int ii = params[j].indexOf("sysModule=");
					if(ii==-1)continue;
					myprem.setSysModule(params[j].substring(10, params[j].length()));
					
				}
				
				
			}else myprem.setPrem(premStr);
			return myprem;
		} catch (RuntimeException e) {
			throw new ApplicationException("权限字符串解析错误："+e.getMessage());
		}
		
		
		
		
	}
	
	
	
	@Override
	public String toString() {
		return "Myprem [prem=" + prem + ", sysModule=" + sysModule + "]";
	}
	
}
