package com.foxtail.service.personnel;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.dao.mybatis.personnel.DeptDao;
import com.foxtail.model.personnel.Dept;
import com.lxr.commons.exception.ApplicationException;
import com.lxr.commons.exception.CheckException;


@Service
public class DeptService {

	@Autowired
	DeptDao deptDao;
	
	
	
	public void save(Dept dept) {
		
		deptDao.save(dept);

	}
	
	
	public void delete(String[] ids) {
		
		Set<String> idSet = new HashSet<>();
		
		for (int i = 0; i < ids.length; i++) {
			idSet.add(ids[i]);
			queryChild(idSet, ids[i]);
		}
		
		if(idSet.size()<1)throw new CheckException("选中数为0");
		
		String[] allid = new String[idSet.size()];
		idSet.toArray(allid);
		
		if(deptDao.placeCount(allid)>0)
			throw new ApplicationException("存在关联职位，不能删除");
		
		deptDao.delete(allid);
		
	}
	
	
	
	
	public void update(Dept dept) {
		
		deptDao.update(dept);
	}
	
	public List findAll() {
		return deptDao.findAll();

	}
	
	public Dept getById(String id) {
		return deptDao.getByid(id);
	}
	
	
	public String[] findBelowIds(String id) {
		Set<String> idSet = new HashSet<>();
		

		queryChild(idSet, id);
		idSet.add(id);
		return idSet.toArray(new String[idSet.size()]);
	}
	
	private void queryChild(Set<String> ids,String pid) {
		
    	List<String> list = deptDao.findByParentid(pid);
    	
    	if(list==null||list.size()<1)return;
    	
    	for (String string: list) {
    		
    		ids.add(string);
			queryChild(ids, string);
			
		}

	}
	
	
	
	
	
	
}
