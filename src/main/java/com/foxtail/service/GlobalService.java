package com.foxtail.service;

import java.net.URLDecoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.foxtail.model.BaseModel;
import com.lxr.commons.exception.ApplicationException;

@Service
public class GlobalService {
	
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public void savetest() {
		
	
		jdbcTemplate.update("insert into _log(name,val) values(1,2)");
		
		if(false)
		throw new ApplicationException();
		
		
		jdbcTemplate.update("insert into _log(name,val) values(2,3)");
		
	}
	
	public void save(BaseModel baseModel) {
		
		System.out.println(baseModel.getCreator());
		// TODO Auto-generated method stub

	}
	
	public static void main(String[] args) {
		System.out.println(URLDecoder.decode("&lt;p&gt;21433534543&lt;/p&gt;"));
	}

}
