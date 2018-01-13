package com.foxtail.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.foxtail.common.page.Pagination;
import com.foxtail.common.util.PublicUtil;
import com.foxtail.dao.mybatis.sys.SysReleaseUserDao;
import com.foxtail.model.sys.SysReleaseUser;
import com.foxtail.model.sys.SysUser;
import com.foxtail.service.sys.SysReleaseUserService;
import com.foxtail.service.sys.SysUserService;
import com.foxtail.vo.sys.SysReleaseUserVo;

@Transactional
@Service("sysReleaseUserService")
public class SysReleaseUserServiceImpl implements SysReleaseUserService{

	private final static Logger log= Logger.getLogger(SysReleaseUserServiceImpl.class);

	@Autowired
	private SysReleaseUserDao sysReleaseUserDao;
	
	@Autowired
	private SysUserService sysUserService;

	
	public SysReleaseUser selectByPrimaryKey(Integer id){
	    return sysReleaseUserDao.selectByPrimaryKey(id);
	}

    public void deleteByPrimaryKey(Integer id){
    	this.sysReleaseUserDao.deleteByPrimaryKey(id); 
    }

    public void insert(SysReleaseUser model) {
    	this.sysReleaseUserDao.insert(model); 
    }
    
    public void insertSelective(SysReleaseUser model){
    	this.sysReleaseUserDao.insertSelective(model); 
    }
    
    public void updateByPrimaryKeySelective(SysReleaseUser model){
    	this.sysReleaseUserDao.updateByPrimaryKeySelective(model); 
    }

    public void updateByPrimaryKey(SysReleaseUser model) {
		this.sysReleaseUserDao.updateByPrimaryKey(model);
    }
    
    public List<SysReleaseUser> selectList(SysReleaseUser sysReleaseUser){
    	return sysReleaseUserDao.selectList(sysReleaseUser);
    }
    
    public List<SysReleaseUser> findAll() {
		return sysReleaseUserDao.findAll();
    }

    public void deleteAll() {
		this.sysReleaseUserDao.deleteAll();
    }

    @Override
    public void deleteIds(String ids){
    	String [] idArr=ids.split(",");
    	if (idArr.length>1) {
			List<Integer> idsList=new ArrayList<Integer>();
			for (int i = 0; i < idArr.length; i++) {
				Integer id=Integer.valueOf(idArr[i]);
				idsList.add(id);
				SysReleaseUser sysReleaseUser = sysReleaseUserDao.selectByPrimaryKey(id);
				if (null!=sysReleaseUser) {
					sysUserService.deleteByPrimaryKey(sysReleaseUser.getUserId());
				}
			}
			this.sysReleaseUserDao.deleteByIds(idsList);
		}else {
			Integer id=Integer.valueOf(ids);
			this.sysReleaseUserDao.deleteByPrimaryKey(id);
			SysReleaseUser sysReleaseUser = sysReleaseUserDao.selectByPrimaryKey(id);
			if (null!=sysReleaseUser) {
				sysUserService.deleteByPrimaryKey(sysReleaseUser.getUserId());
			}
		}
    }

    @Override
    public Pagination findListByPage(int rows, int page,SysReleaseUserVo vo) {
	    Pagination pagination = new Pagination();
	    pagination.setPageNo(page); //当前页码
	    pagination.setPageSize(rows);  //每页显示多少行
	    List<SysReleaseUserVo>  list = this.sysReleaseUserDao.findListByPage(vo,pagination);
	    pagination.setList(list);
	    return pagination;
    }

	@Override
	public void saveSysReleaserUser(SysReleaseUserVo sysReleaseUserVo) {
		SysUser sysUser = sysReleaseUserVo.getSysUser();
		sysUserService.insertSelective(sysUser);
		SysReleaseUser sysReleaseUser=new SysReleaseUser();
		BeanUtils.copyProperties(sysReleaseUserVo, sysReleaseUser);
		Integer orgType = sysReleaseUser.getOrgType();
		if (SysReleaseUser.ORG_TYPE_COMMUNITY.equals(orgType)||SysReleaseUser.ORG_TYPE_VOLUNTEERING.equals(orgType)) {
			sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_COMMON);
		}else if (SysReleaseUser.ORG_TYPE_YOUTH.equals(orgType)) {
			sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_SUPER);
		}else {
			sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_LIMIT);
		}
		sysReleaseUser.setUserId(sysUser.getId());
		sysReleaseUserDao.insertSelective(sysReleaseUser);
	}

	@Override
	public void editSysReleaserUser(SysReleaseUserVo sysReleaseUserVo) {
		SysUser sysUser = sysReleaseUserVo.getSysUser();
		sysUserService.updateByPrimaryKeySelective(sysUser);
		SysReleaseUser sysReleaseUser=new SysReleaseUser();
		BeanUtils.copyProperties(sysReleaseUserVo, sysReleaseUser);
		Integer orgType = sysReleaseUser.getOrgType();
		if (SysReleaseUser.ORG_TYPE_COMMUNITY.equals(orgType)||SysReleaseUser.ORG_TYPE_VOLUNTEERING.equals(orgType)) {
			sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_COMMON);
		}else if (SysReleaseUser.ORG_TYPE_YOUTH.equals(orgType)) {
			sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_SUPER);
		}else {
			sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_LIMIT);
		}
		sysReleaseUserDao.updateByPrimaryKeySelective(sysReleaseUser);
	}

	@Override
	public void setLimited(String ids) {
		if (!PublicUtil.checkEmptyString(ids)) {
			String[] idArr = ids.split(",");
			for (int i = 0; i < idArr.length; i++) {
				Integer id=Integer.valueOf(idArr[i]);
				SysReleaseUser sysReleaseUser=new SysReleaseUser();
				sysReleaseUser.setId(id);
				sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_LIMIT);
				sysReleaseUserDao.updateByPrimaryKeySelective(sysReleaseUser);
			}
		}
	}

	@Override
	public void setCommon(String ids) {
		if (!PublicUtil.checkEmptyString(ids)) {
			String[] idArr = ids.split(",");
			for (int i = 0; i < idArr.length; i++) {
				Integer id=Integer.valueOf(idArr[i]);
				SysReleaseUser sysReleaseUser=new SysReleaseUser();
				sysReleaseUser.setId(id);
				sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_COMMON);
				sysReleaseUserDao.updateByPrimaryKeySelective(sysReleaseUser);
			}
		}
	}

	@Override
	public void setWhite(String ids) {
		if (!PublicUtil.checkEmptyString(ids)) {
			String[] idArr = ids.split(",");
			for (int i = 0; i < idArr.length; i++) {
				Integer id=Integer.valueOf(idArr[i]);
				SysReleaseUser sysReleaseUser=new SysReleaseUser();
				sysReleaseUser.setId(id);
				sysReleaseUser.setReleaseType(SysReleaseUser.TYPE_SUPER);
				sysReleaseUserDao.updateByPrimaryKeySelective(sysReleaseUser);
			}
		}
	}

}

