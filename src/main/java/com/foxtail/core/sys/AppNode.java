package com.foxtail.core.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AppNode {

	String name;
	String key;
	Integer level;
	String url;
	String perms;
	
	Map<String, AppNode> nodes = new HashMap<>();
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPerms() {
		return perms;
	}
	public void setPerms(String perms) {
		this.perms = perms;
	}
	public Map<String, AppNode> getNodes() {
		return nodes;
	}
	public void setNodes(Map<String, AppNode> nodes) {
		this.nodes = nodes;
	}
	@Override
	public String toString() {
		return "AppNode [name=" + name + ", key=" + key + ", level=" + level + ", url=" + url + ", perms=" + perms
				+ ", nodes=" + nodes + "]";
	}
	
	
	
	
}
