package com.foxtail.service.sys.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foxtail.common.page.Pagination;
import com.foxtail.common.util.MD5Util;
import com.foxtail.common.util.PublicUtil;
import com.foxtail.common.util.TcpipUtil;
import com.foxtail.core.util.ContextHolderUtils;
import com.foxtail.core.util.PropertiesUtil;
import com.foxtail.dao.mybatis.sys.SysUserDao;
import com.foxtail.dao.mybatis.sys.SysUserRoleDao;
import com.foxtail.model.sys.SysUser;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.service.sys.SysUserService;
import com.foxtail.vo.sys.SysUserVo;

@Transactional
@Service("sysUserService")
public class SysUserServiceImpl implements SysUserService{

	private final static Logger log= Logger.getLogger(SysUserServiceImpl.class);

	@Autowired
	private SysUserDao sysUserDao;
	
	@Autowired
	private SysUserRoleDao sysUserRoleDao;

	
	public SysUser selectByPrimaryKey(Integer id){
	    return sysUserDao.selectByPrimaryKey(id);
	}

    public void deleteByPrimaryKey(Integer id){
    	this.sysUserDao.deleteByPrimaryKey(id); 
    }

    public void insert(SysUser model) {
	    HttpServletRequest request=ContextHolderUtils.getRequest();
	    String ipAddr = TcpipUtil.getIpAddr(request);
    	model.setRegIp(ipAddr);
    	model.setRegTime(new Date());
    	String rawPwd=model.getPassword();
    	if (PublicUtil.checkEmptyString(rawPwd)) {
			rawPwd=PropertiesUtil.getString("sys.defaultPwd");
		}
    	String password = MD5Util.string2MD5(rawPwd);
    	model.setPassword(password);
    	this.sysUserDao.insert(model); 
    }
    
    public void insertSelective(SysUser model){
    	HttpServletRequest request=ContextHolderUtils.getRequest();
	    String ipAddr = TcpipUtil.getIpAddr(request);
    	model.setRegIp(ipAddr);
    	model.setRegTime(new Date());
    	String rawPwd=model.getPassword();
    	if (PublicUtil.checkEmptyString(rawPwd)) {
			rawPwd=PropertiesUtil.getString("sys.defaultPwd");
		}
    	String password = MD5Util.string2MD5(rawPwd);
    	model.setPassword(password);
    	this.sysUserDao.insertSelective(model); 
    }
    
    public void updateByPrimaryKeySelective(SysUser model){
    	this.sysUserDao.updateByPrimaryKeySelective(model); 
    }

    public void updateByPrimaryKey(SysUser model) {
		this.sysUserDao.updateByPrimaryKey(model);
    }
    
    public List<SysUser> selectList(SysUser sysUser){
    	return sysUserDao.selectList(sysUser);
    }
    
    public List<SysUser> findAll() {
		return sysUserDao.findAll();
    }

    public void deleteAll() {
		this.sysUserDao.deleteAll();
    }

    @Override
    public void deleteIds(String ids){
    	String [] idArr=ids.split(",");
    	if (idArr.length>1) {
			List<Integer> idsList=new ArrayList<Integer>();
			for (int i = 0; i < idArr.length; i++) {
				Integer userId=Integer.valueOf(idArr[i]);
				idsList.add(userId);
				sysUserRoleDao.deleteByUserId(userId);
			}
			if (!PublicUtil.checkEmptyList(idsList)) {
				this.sysUserDao.deleteByIds(idsList);
			}
		}else {
			this.sysUserDao.deleteByPrimaryKey(Integer.valueOf(ids));
		}
    }

    @Override
    public Pagination findListByPage(int rows, int page,SysUserVo vo) {
	    Pagination pagination = new Pagination();
	    pagination.setPageNo(page); //当前页码
	    pagination.setPageSize(rows);  //每页显示多少行
	    List<SysUserVo>  list = this.sysUserDao.findListByPage(vo,pagination);
	    pagination.setList(list);
	    return pagination;
    }

	@Override
	public SysUser findSingleUser(String account) {
		return this.sysUserDao.findSingleUser(account);
	}

	@Override
	public void setUserRole(SysUserRole[] sysUserRoles) {
		if (null!=sysUserRoles&&sysUserRoles.length>0) {
			Integer userId=sysUserRoles[0].getUserId();
			sysUserRoleDao.deleteByUserId(userId);
			for (SysUserRole sysUserRole : sysUserRoles) {
				sysUserRoleDao.insertSelective(sysUserRole);
			}
		}
		
	}

	@Override
	public boolean findIsExist(String name, String type) {
		Map<String, String> map=new HashMap<String,String>();
		if (SysUserVo.CHECK_TYPE_ACCOUNT.equals(type)) {
			map.put("account", name);
		}else if (SysUserVo.CHECK_TYPE_EMAIL.equals(type)) {
			map.put("email", name);
		}else if (SysUserVo.CHECK_TYPE_MOBILEPHONE.equals(type)) {
			map.put("mobilePhone", name);
		}else if (SysUserVo.CHECK_TYPE_IDNUMBER.equals(type)) {
			map.put("idNumber", name);
		}
		Integer count = sysUserDao.selectCountIsExist(map);
		if (count>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean updateByAccount(SysUser sysUser) {
		
		if(sysUser.getPassword()!=null)
			sysUser.setPassword(MD5Util.string2MD5(sysUser.getPassword()));
		
		return sysUserDao.updateByAccount(sysUser);
	}
	
	@Override
	public void deleteByAccouts(String[] accounts) {
		
		sysUserRoleDao.deleteByAccounts(accounts);
		sysUserDao.deleteByAccounts(accounts);
		
	} 	
	
}

