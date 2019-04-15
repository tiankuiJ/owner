package com.kafei.util;

import com.github.pagehelper.Page;

import java.util.HashMap;
import java.util.Map;

public class PageUtil {
	
	public static Map<String, Object> getResult(Page page){
		Map<String, Object> map = new HashMap<>();
		map.put("page", page.getPageNum());//当前页
		map.put("pageSize", page.getPageSize());
		map.put("total", page.getPages());//总页数
		map.put("records", page.getTotal());//总条数
		map.put("rows", page.getResult());//查询结果
		return map;
	}

}
