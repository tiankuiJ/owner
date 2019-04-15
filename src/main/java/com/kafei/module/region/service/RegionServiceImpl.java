package com.kafei.module.region.service;

import com.kafei.mapper.RegionMapper;
import com.kafei.vo.Menu;
import com.kafei.vo.Region;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class RegionServiceImpl implements RegionService {
	@Autowired
	private RegionMapper mapper;
	@Override
	public List<Menu> getRegionTree() {
		List<Region> resources = mapper.getAll();
		List<Menu> menuList = convertToMenus(resources);
		List<Menu> list = new ArrayList<Menu>();
		Menu m = new Menu(0l, "全国", 0l,"");
		m.setIsRoot(true);
		m.setChildren(menuList);
		list.add(m);
		return menuList;
	}
	private List<Menu> convertToMenus(List<Region> resources) {
		if (resources.size() == 0) {
			return Collections.EMPTY_LIST;
		}
		Menu root = convertToMenu(resources.remove(resources.size() - 1));
		recursiveMenu(root, resources);
		List<Menu> menus = root.getChildren();
		removeNoLeafMenu(menus);
		return menus;
	}
	private void removeNoLeafMenu(List<Menu> menus) {
		if (menus.size() == 0) {
            return;
        }
        for (int i = menus.size() - 1; i >= 0; i--) {
            Menu m = menus.get(i);
            removeNoLeafMenu(m.getChildren());
        }
	}
	private void recursiveMenu(Menu menu, List<Region> resources) {
		for (int i = resources.size() - 1; i >= 0; i--) {
			Region resource = resources.get(i);
			if (resource.getParentid().equals(menu.getCode())) {
				menu.getChildren().add(convertToMenu(resource));
				resources.remove(i);
			}
		}
		for (Menu subMenu : menu.getChildren()) {
			recursiveMenu(subMenu, resources);
		}
		
	}
	/**
	 * 存编码
	 * @param remove
	 * @return
	 */
	private Menu convertToMenu(Region remove) {
		return new Menu(remove.getCode(), remove.getCode(), remove.getName(), remove.getParentid());
	}
	
	@Override
	public List<Menu> getListByPid(Long pid) {
		if(pid==null){
			pid=0l;
		}
		List<Region> list = mapper.getListByPid(pid);
		List<Menu> menuList = new ArrayList<Menu>();
		String state="closed";
		for(Region m:list){
			if(m.getChildSize().intValue()>0){
				state="closed";
			}else{
				state="open";
			}
			menuList.add(new Menu(m.getCode(),m.getName(),state));
		}
		return menuList;
	}
	@Override
	public String getNameById(Integer id) {
		return mapper.getNameById((long)id);
	}
	@Override
	public List<Menu> getListByPidWithSelf(Long pid) {
		if(pid==null){
			pid=0l;
		}
		List<Region> list = mapper.getListByPidWithSelf(pid);
		List<Menu> menuList = new ArrayList<Menu>();
		Menu menu = null;
		String state="closed";
		for(Region m:list){
			if(m.getChildSize().intValue()>0){
				state="closed";
			}else{
				state="open";
			}
			if(m.getCode().equals(pid)){
				menu = new Menu(m.getCode(),m.getName(),"open");
			}else{
				menuList.add(new Menu(m.getCode(),m.getName(),state));
			}
		}
		if(menu!=null){
			menu.setChildren(menuList);
			List<Menu> all = new ArrayList<Menu>();
			all.add(menu);
			return all;
		}
		return menuList;
	}
	
	
	
}
