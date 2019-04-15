package com.kafei.module.region.service;



import com.kafei.vo.Menu;

import java.util.List;

public interface RegionService {
	public List<Menu> getRegionTree();
	List<Menu> getListByPid(Long pid);
	List<Menu> getListByPidWithSelf(Long pid);
	String getNameById(Integer id);
}
