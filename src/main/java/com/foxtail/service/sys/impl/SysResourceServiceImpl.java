package com.foxtail.service.sys.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foxtail.common.page.Pagination;
import com.foxtail.common.util.PublicUtil;
import com.foxtail.core.shiro.Myprem;
import com.foxtail.core.shiro.PermManager;
import com.foxtail.core.shiro.ShiroUser;
import com.foxtail.dao.mybatis.sys.SysResourceDao;
import com.foxtail.dao.mybatis.sys.SysRoleResourceDao;
import com.foxtail.model.sys.SysResource;
import com.foxtail.service.sys.SysResourceService;
import com.foxtail.vo.sys.SysResourceVo;
import com.lxr.commons.exception.ApplicationException;

@Transactional
@Service("sysResourceService")
public class SysResourceServiceImpl implements SysResourceService{

	private final static Logger log= Logger.getLogger(SysResourceServiceImpl.class);

	@Autowired
	private SysResourceDao sysResourceDao;
	
	@Autowired
	SysRoleResourceDao sysRoleResourceDao;
	
	List<SysResource> sysResources;
	
	boolean ismodify = true;

	
	public SysResource selectByPrimaryKey(Integer id){
	    return sysResourceDao.selectByPrimaryKey(id);
	}

    public void deleteByPrimaryKey(Integer id){
    	this.sysResourceDao.deleteByPrimaryKey(id); 
    	ismodify = true;
    }

    public void insert(SysResource model) {
    	model.setCreateTime(new Date());
    	model.setCreateUserId(ShiroUser.getUserId());
    	this.sysResourceDao.insert(model); 
    	ismodify = true;
    }
    
    public void insertSelective(SysResource model){
    	model.setCreateTime(new Date());
    	model.setCreateUserId(ShiroUser.getUserId());
    	this.sysResourceDao.insertSelective(model); 
    	ismodify = true;
    }
    
    public void updateByPrimaryKeySelective(SysResource model){
    	model.setModifyTime(new Date());
    	model.setModifyUserId(ShiroUser.getUserId());
    	this.sysResourceDao.updateByPrimaryKeySelective(model); 
    	ismodify = true;
    }

    public void updateByPrimaryKey(SysResource model) {
    	model.setModifyTime(new Date());
    	model.setModifyUserId(ShiroUser.getUserId());
		this.sysResourceDao.updateByPrimaryKey(model);
		ismodify = true;
    }
    
    public List<SysResource> selectList(SysResource sysResource){
    	return sysResourceDao.selectList(sysResource);
    }
    
    public List<SysResource> findAll() {
    	if(sysResources==null||ismodify) {
    	
    		sysResources = sysResourceDao.findAll();
    		
    		onUpdate();
    		
        	ismodify = false;
    	} else 	System.out.println("抓取缓存");
    	
		return sysResources;
    }
    
    
    public void onUpdate() {
    	PermManager.getAllPerms().clear();
    	for (SysResource res : sysResources) {
    		if(StringUtils.isBlank(res.getPermissionStr()))continue;
    		
			Myprem myprem = Myprem.getMyprem(res.getPermissionStr());
			List<Myprem> myprems = PermManager.getAllPerms().get(myprem.getUrl());
			if(myprems==null) { myprems = new ArrayList<Myprem>();PermManager.getAllPerms().put(myprem.getUrl(), myprems);}
			myprems.add(myprem);
    	
    	}
    }
    
    

    public void deleteAll() {
		this.sysResourceDao.deleteAll();
		ismodify = true;
    }

    @Override
    public void deleteIds(String ids){
    	String [] idArr=ids.split(",");
    	
    	//所有需要删除的ID
    	Set<Integer> idd = new HashSet<>();
    	
    	if (idArr.length<1) throw new ApplicationException("ids="+ids);
			
			for (int i = 0; i < idArr.length; i++) {
				Integer id = Integer.valueOf((idArr[i]));
				idd.add(id);
				queryChild(idd, id);
				
				
			}
			
			
			List l = new ArrayList<>(idd);
			sysResourceDao.deleteByIds(l);
			
		
			//删除关联表
			sysRoleResourceDao.deleteByResources(l);
			
		ismodify = true;
    }
    
    
    private void queryChild(Set<Integer> ids,Integer pid) {
		
    	List<SysResource> list = sysResourceDao.selectListByParentId(Integer.valueOf(pid));
    	
    	if(list==null||list.size()<1)return;
    	
    	for (SysResource sysResource : list) {
    		Integer id = sysResource.getId();
    		ids.add(id);
			queryChild(ids, id);
			
		}

	}
    
    public String queryUriName(String uri) {
    	List<SysResource> list = sysResourceDao.queryUriName(uri);
    	if(list==null||list.size()<1)return "";
    	
    	if(list.size()>1)System.out.println("警告：多个资源uri相同");
    	
		return list.get(0).getResourceName();

	}
    

    @Override
    public Pagination findListByPage(int rows, int page,SysResourceVo vo) {
	    Pagination pagination = new Pagination();
	    pagination.setPageNo(page); //当前页码
	    pagination.setPageSize(rows);  //每页显示多少行
	    List<SysResourceVo>  list = this.sysResourceDao.findListByPage(vo,pagination);
	    pagination.setList(list);
	    return pagination;
    } 
    
    @Override
	public List<SysResource> selectListByParentId(Integer parentId) {
		
		return this.sysResourceDao.selectListByParentId(parentId);
	}

	@Override
	public void saveAndCreateRes(SysResource po, boolean createButton) {
		po.setCreateTime(new Date());
		po.setCreateUserId(ShiroUser.getUserId());
    	this.sysResourceDao.insertSelective(po); 
    	if(createButton){
    		this.createButtonRes(po);
    	}
    	ismodify = true;
	}
	
	public SysResourceVo selectVoByPrimaryKey(Integer id) {
		return this.sysResourceDao.selectVoByPrimaryKey(id);
	}

	@Override
	public void createButtonRes(SysResource po) {
		String permissionStr = po.getPermissionStr();
		String resName = null;
		if(null != permissionStr && !"".equals(permissionStr.trim())){
			int len = permissionStr.indexOf(":");
			if(len != -1){
				resName = permissionStr.substring(0, len);
			}
		}
		if(null == resName ){
			return;
		}
		SysResource res = new SysResource();
		res.setParentId(po.getId());
		res.setResourcePath("/");
		res.setLevel(po.getLevel() + 1);
		res.setCreateTime(new Date());
		res.setCreateUserId(ShiroUser.getUserId());
		res.setIsEnable(1);
		//添加
		res.setResourceName(po.getResourceName() + "-添加");
		res.setOrderNum(1);
		res.setPermissionStr(resName + ":add");
		res.setResourceDesc(po.getResourceName() + "添加操作");
		res.setId(null);
		res.setCreateTime(new Date());
		res.setCreateUserId(ShiroUser.getUserId());
		this.insertSelective(res);
		//删除
		res.setResourceName(po.getResourceName() + "-删除");
		res.setOrderNum(2);
		res.setPermissionStr(resName + ":remove");
		res.setResourceDesc(po.getResourceName() + "删除操作");
		res.setId(null);
		res.setCreateTime(new Date());
		res.setCreateUserId(ShiroUser.getUserId());
		this.insertSelective(res);
		//编辑
		res.setResourceName(po.getResourceName() + "-编辑");
		res.setOrderNum(3);
		res.setPermissionStr(resName + ":edit");
		res.setResourceDesc(po.getResourceName() + "编辑操作");
		res.setCreateTime(new Date());
		res.setCreateUserId(ShiroUser.getUserId());
		res.setId(null);
		this.insertSelective(res);
		//查看
		res.setResourceName(po.getResourceName() + "-查看");
		res.setOrderNum(4);
		res.setPermissionStr(resName + ":info");
		res.setResourceDesc(po.getResourceName() + "查看操作");
		res.setId(null);
		res.setCreateTime(new Date());
		res.setCreateUserId(ShiroUser.getUserId());
		this.insertSelective(res);
	}

	@Override
	public List<SysResourceVo> findAuthorizationAll(Integer roleId) {
		return sysResourceDao.findAuthorizationAll(roleId);
	}

	@Override
	public List<SysResource> findAllByUserId(Integer userId) {
		findAll();
		return this.sysResourceDao.findAllByUserId(userId);
	}

	@Override
	public Integer selectResourceReference(Integer resourceId) {
		return this.sysResourceDao.selectResourceReference(resourceId);
	}
}

