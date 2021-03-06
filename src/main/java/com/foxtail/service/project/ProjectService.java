package com.foxtail.service.project;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.PrjCollectDao;
import com.foxtail.dao.mybatis.project.PrjMebDao;
import com.foxtail.dao.mybatis.project.ProjectDao;
import com.foxtail.filter.ProjectFilter;
import com.foxtail.model.project.PrjCollect;
import com.foxtail.model.project.PrjMeb;
import com.foxtail.model.project.Project;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.lxr.commons.exception.ApplicationException;


@Service
public class ProjectService {

	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	PrjMebDao prjMebDao;
	
	
	@Autowired
	PrjCollectService prjCollectService;
	
	
	public void save(Project project) {
		
		projectDao.save(project);
		if(project.getProductids()!=null)
		for (String id : project.getProductids()) {
			projectDao.saveProduct(project.getId(), id);
		}
		if(project.getMebs()!=null&&project.getMebs().size()>0)
		prjMebDao.saveMebs(project.getId(),toPrjMeb(project.getMebs()));
		
		if(project.getReceived()==null||project.getReceived()<=0)return;

		PrjCollect prjCollect = new PrjCollect();
		prjCollect.setType(1);
		prjCollect.setEmpid(project.getOrderempid());
		prjCollect.setMoney(project.getReceived());
		prjCollect.setPrjid(project.getId());
		prjCollect.setTime(System.currentTimeMillis());
		
		prjCollectService.save(prjCollect);

	}
	
	private List<PrjMeb> toPrjMeb(List<Map<String, Object>> mebs) {
		List<PrjMeb> prjMebs = new ArrayList<>();
		for (Map<String, Object> map : mebs) {
			PrjMeb meb = new PrjMeb();
			meb.setEmpid(map.get("empid").toString());
			meb.setRole(map.get("role").toString());
			prjMebs.add(meb);
		}
		return prjMebs;

	}
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_project", ids);
		projectDao.deleteAllProduct(ids);
		projectDao.deleteAllCollect(ids);
		
	}
	
	
	public void update(Project project) {
	
		projectDao.update(project);
		projectDao.deleteAllProduct(new String[] {project.getId()}); 
		if(project.getProductids()!=null)
			for (String id : project.getProductids()) {
				projectDao.saveProduct(project.getId(), id);
		}
		
		updateMebs(project.getId(), project.getMebs());
		
	}
	
	private void updateMebs(String prjid,List<Map<String, Object>> mebs) {
		if(mebs==null||mebs.size()<1) {
			projectDao.deleteAllMebs(new String[] {prjid});
			return;
			}
		
		List<PrjMeb> dbmebs = prjMebDao.findAll(prjid);
		
		List<PrjMeb> nMebs = new ArrayList<>();
		for (int i = 0; i < mebs.size(); i++) {
			String empid = mebs.get(i).get("empid").toString();
			String role = mebs.get(i).get("role").toString();
			
			nMebs.add(getMeb(prjid,empid, role, dbmebs));
		}
		
		projectDao.deleteAllMebs(new String[] {prjid});
		prjMebDao.saveMebs(prjid,nMebs);

	}
	
	private PrjMeb getMeb(String prjid,String empid,String role,List<PrjMeb> mebs) {
		
		for (PrjMeb prjMeb : mebs) {
			if(prjMeb.getEmpid().equals(empid)) {
				prjMeb.setRole(role);
				return prjMeb;
			}	
		}
		
		PrjMeb meb = new PrjMeb();
		meb.setEmpid(empid);
		meb.setRole(role);
		meb.setPrjid(prjid);
		return meb;

	}
	
	
	private String[] getIds(List<Map<String, Object>> maps) {
		String[] uids = new String[maps.size()];
		
		for (int i = 0; i < maps.size(); i++) {
			uids[i] = maps.get(i).get("empid").toString();
		}
		
		return uids;

	}
	
	
	public Pagination findForPage(Pagination page,ProjectFilter filter) {
		
		switch (filter.getSysView()) {
		
		case "below":
			filter.setUid(null);
			filter.setUid2(filter.getUid());
			filter.setUdeptids(new String[] {filter.getDeptid()});
			break;
		case "all":
			filter.setUdeptids(null);
			filter.setUid(null);
			break;
		case "def":
			filter.setUdeptids(null);
		default:
			break;
		}
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)projectDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public Project getById(String id) {
		
		Project project = projectDao.getById(id);
		project.setProducts(projectDao.findProducts(id));
		project.setMebs(projectDao.findMebs(id));
		return project;
	}

	
	public List<PrjMeb> findMebs(String prjid) {
		return prjMebDao.findAll(prjid);

	}
	
	
	/**
	 * 
	 * @param prjid
	 * @param uid
	 * @return 1:不存在该项目中，2：未开始，3：已开始
	 */
	public int getUserState(String prjid,String uid) {
		Map<String, Object> meb = prjMebDao.getPrjMeb(prjid, uid);
		if(meb==null)return 1;
		if(meb.get("intime")==null)return 2;
		return 3;

	}
	
	public void doStart(String prjid,String uid) {
		Map<String, Object> meb = prjMebDao.getPrjMeb(prjid, uid);
		if(meb==null)throw new ApplicationException("该成员未在项目中");
		
		long ctime = System.currentTimeMillis();
		
		Map<String, Object> umMap = new HashMap<>();
		umMap.put("id", meb.get("id"));
		
		if(meb.get("starttime")==null) {
			umMap.put("starttime", ctime);
			umMap.put("intime", ctime);
			prjMebDao.updateMeb(umMap);
			return;
		}
		
		if(meb.get("intime")!=null)throw new ApplicationException("该项目已经开始");
		
		umMap.put("intime", ctime);
		prjMebDao.updateMeb(umMap);
		
	}
	
	public void doEnd(String prjid,String uid) {
		Map<String, Object> meb = prjMebDao.getPrjMeb(prjid, uid);
		if(meb==null)throw new ApplicationException("该成员未在项目中");
		
		if(meb.get("starttime")==null||meb.get("intime")==null) 
			throw new ApplicationException("该项目未开始");
		
		long ctime = System.currentTimeMillis();
		
		double usetime = Double.valueOf(meb.get("usetime").toString())
				+genTime(Long.valueOf(meb.get("intime").toString()), ctime);
		
		
		Map<String, Object> umMap = new HashMap<>();
		umMap.put("id", meb.get("id"));
		umMap.put("usetime", usetime);
		prjMebDao.updateMeb(umMap);

	}
	
	
	
	public void setAlltime(String prjid,String uid,double alltime) {
		prjMebDao.setAlltime(uid, prjid, alltime);

	}
	
	private double genTime(long stime,long endtime) {
		int h = (int) (endtime-stime)/(1000*60*60);
		return ((double)(h/4))/2;

	}
	
	public static void main(String[] args) {
		System.out.println(((double)(12/4))/2);
	}
	
}


