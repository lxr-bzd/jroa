package com.foxtail.service.sys.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foxtail.common.page.Pagination;
import com.foxtail.common.util.PublicUtil;
import com.foxtail.core.shiro.CustomRealm;
import com.foxtail.core.shiro.ShiroUser;
import com.foxtail.dao.mybatis.sys.SysRoleDao;
import com.foxtail.dao.mybatis.sys.SysRoleResourceDao;
import com.foxtail.dao.mybatis.sys.SysUserRoleDao;
import com.foxtail.model.sys.SysRole;
import com.foxtail.model.sys.SysRoleResource;
import com.foxtail.service.sys.SysRoleService;
import com.foxtail.vo.sys.SysRoleVo;
import com.lxr.commons.exception.ApplicationException;

@Transactional
@Service("sysRoleService")
public class SysRoleServiceImpl implements SysRoleService{

	private final static Logger log= Logger.getLogger(SysRoleServiceImpl.class);

	@Autowired
	private SysRoleDao sysRoleDao;
	@Autowired
	private SysRoleResourceDao sysRoleResourceDao;
	
	@Autowired
	private SysUserRoleDao sysUserRoleDao;
	
	@Autowired
	private CustomRealm customRealm;

	
	public SysRole selectByPrimaryKey(Integer id){
	    return sysRoleDao.selectByPrimaryKey(id);
	}

    public void deleteByPrimaryKey(Integer id){
    	this.sysRoleDao.deleteByPrimaryKey(id); 
    }

    public void insert(SysRole model) {
    	model.setCreateTime(new Date());
    	model.setCreateUserId(ShiroUser.getUserId());
    	this.sysRoleDao.insert(model); 
    }
    
    public void insertSelective(SysRole model){
    	model.setCreateTime(new Date());
    	model.setCreateUserId(ShiroUser.getUserId());
    	this.sysRoleDao.insertSelective(model); 
    }
    
    public void updateByPrimaryKeySelective(SysRole model){
    	model.setModifyTime(new Date());
    	model.setModifyUserId(ShiroUser.getUserId());
    	this.sysRoleDao.updateByPrimaryKeySelective(model); 
    }

    public void updateByPrimaryKey(SysRole model) {
    	model.setModifyTime(new Date());
    	model.setModifyUserId(ShiroUser.getUserId());
		this.sysRoleDao.updateByPrimaryKey(model);
    }
    
    public List<SysRole> selectList(SysRole sysRole){
    	return sysRoleDao.selectList(sysRole);
    }
    
    public List<SysRole> findAll() {
		return sysRoleDao.findAll();
    }

    public void deleteAll() {
		this.sysRoleDao.deleteAll();
    }
    
    @Override
	public void deleteIds(String[] ids) {
		
		if(ids==null||ids.length<1)
			throw new ApplicationException("删除数量不能为空");
		
			sysRoleResourceDao.deleteByRoleIds(ids);
			sysUserRoleDao.deleteByRoleIds(ids);
			
			this.sysRoleDao.deleteByIds(ids);
		
	}
    

    @Override
    public Pagination findListByPage(int rows, int page,SysRoleVo vo) {
	    Pagination pagination = new Pagination();
	    pagination.setPageNo(page); //当前页码
	    pagination.setPageSize(rows);  //每页显示多少行
	    List<SysRoleVo>  list = this.sysRoleDao.findListByPage(vo,pagination);
	    pagination.setList(list);
	    return pagination;
    }

	@Override
	public void setRoleResources(String roleid,String[] resids) {
	
			sysRoleResourceDao.deleteByRoleId(Integer.parseInt(roleid));
			for (String resid : resids) {
				SysRoleResource roleResource = new SysRoleResource();
				roleResource.setRoleId(Integer.parseInt(roleid));
				roleResource.setResourceId(Integer.parseInt(resid));
				sysRoleResourceDao.insertSelective(roleResource);
			}
			customRealm.clearCached();
		
	}

	@Override
	public List<String> findRoleTypesByUserId(Integer userId) {
		System.out.println("findRoleTypesByUserId");
		return sysRoleDao.findRoleTypesByUserId(userId);
	}

	@Override
	public void copyResources(String roleid, String copyRoleid) {
		
		sysRoleResourceDao.deleteByRoleId(Integer.valueOf(roleid));
		sysRoleDao.copyResources(roleid, copyRoleid);
		
	}

	
}

