package com.foxtail.service.personnel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.PlaceDao;
import com.foxtail.model.personnel.Place;
import com.foxtail.model.sys.SysRole;
import com.foxtail.service.sys.SysRoleService;
import com.lxr.commons.exception.ApplicationException;


@Service
public class PlaceService {

	@Autowired
	PlaceDao placeDao;
	
	@Autowired
	SysRoleService sysRoleService;
	
	
	public void save(Place place) {
		
		SysRole role = new SysRole();
		role.setRoleName(place.getName());
		role.setRoleDesc(place.getRemark());
		role.setRoleStatus(place.getState()+1);
		sysRoleService.insert(role);
		if(role.getId()!=null)
		place.setRoleid(role.getId()+"");
		placeDao.save(place);

	}
	
	
	public void delete(String[] ids) {
		
		if(placeDao.levelCount(ids)>0)
			throw new ApplicationException("存在关联等级，不能删除");
		
		sysRoleService.deleteIds(placeDao.findRoleidsByIds(ids));
		
		ServiceManager.commonService.delete("man_place", ids);
		
	}
	
	
	public void update(Place place) {
		
		placeDao.update(place);
	}
	
	public Pagination findForPage(Pagination page,String kw) {
		
		List  list = placeDao.findForPage(page,kw);
		page.setList(list);
		return page;

	}
	
	public List<Place> findByDeptid(String deptid) {
		return placeDao.findByDeptid(deptid);

	}
	
	
	public Place getById(String id) {
		
		return placeDao.getById(id);

	}
	
	
	
	
}

