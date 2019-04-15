package com.kafei.module.region;

import com.kafei.module.region.service.RegionService;
import com.kafei.vo.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("region")
public class RegionController {
	@Autowired
	private RegionService regionService;

	@RequestMapping("tree")
	@ResponseBody
	public List<Menu> getRegionTree(){
		return regionService.getRegionTree();
	}
	
	@RequestMapping("getByPid")
	@ResponseBody
	public List<Menu> getListByPid(Long id, HttpServletRequest request){
		return regionService.getListByPid(id);
	}
}
