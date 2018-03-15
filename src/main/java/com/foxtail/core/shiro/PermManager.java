package com.foxtail.core.shiro;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PermManager {

	 static Map<String, List<Myprem>> perms = new HashMap<>();
	
	 public static Map<String, List<Myprem>> getAllPerms(){
		 
		 return perms;
		 
	 }
	
}
