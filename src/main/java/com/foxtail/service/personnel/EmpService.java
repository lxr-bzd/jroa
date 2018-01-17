package com.foxtail.service.personnel;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.EmpDao;
import com.foxtail.filter.EmpFilter;
import com.foxtail.model.personnel.Emp;
import com.foxtail.model.personnel.Place;
import com.foxtail.model.sys.SysUser;
import com.foxtail.model.sys.SysUserRole;
import com.foxtail.service.sys.SysUserRoleService;
import com.foxtail.service.sys.SysUserService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class EmpService {

	@Autowired
	EmpDao empDao;
	
	@Autowired
	SysUserService sysUserService;
	
	@Autowired
	SysUserRoleService sysUserRoleService;
	
	@Autowired
	PlaceService placeService;
	
	
	public void save(Emp emp) {
		
		emp.setAccount(emp.getAccount());
		//添加员工
		empDao.save(emp);
		
		if(!StringUtils.isEmpty(emp.getAccount())) {
			SysUser sysUser = new SysUser();
			sysUser.setAccount(emp.getAccount());
			sysUser.setUserName(emp.getName());
			sysUser.setPassword(emp.getPwd());
			sysUser.setStatus(Integer.parseInt(emp.getState()));
			//添加账号
			sysUserService.insert(sysUser);
			Place place = placeService.getById(emp.getPlaceid());
			SysUserRole userRole = new SysUserRole();
			userRole.setRoleId(Integer.parseInt(place.getRoleid()));
			userRole.setUserId(sysUser.getId());
			sysUserRoleService.insert(userRole);
		}
		
	
		

	}
	
	
	
	
	public void delete(String[] ids) {
		sysUserService.deleteByAccouts(getAccountsByIds(ids));
		ServiceManager.commonService.delete("man_emp", ids);
	}
	
	private String[] getAccountsByIds(String[] ids) {
		
		return empDao.getAccountsByIds(ids);
	}
	
	
	public void update(Emp emp) {
		
		Emp pEmp =  getById(emp.getId());
		
		SysUser sysUser = new SysUser();
		sysUser.setAccount(pEmp.getName());
		sysUser.setPassword(pEmp.getPwd());
		
		sysUserService.updateByAccount(sysUser);
		
		empDao.update(emp);

	}
	
	public Pagination findForPage(Pagination page,EmpFilter filter) {
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)empDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
	}
	
	
	public Emp getById(String id) {
		
		return empDao.getById(id);

	}

	
	
	
	
}


