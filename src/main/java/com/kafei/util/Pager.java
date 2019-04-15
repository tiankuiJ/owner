package com.kafei.util;

public class Pager{
	/**
	 * 是否有查询条件
	 */
	private boolean _search;
	/**
	 * 当前页
	 */
	private int page;
	/**
	 * 每页查询数量
	 */
	private int rows;
	/**
	 * 排序字段
	 */
	private String sidx;
	/**
	 * 排序方式
	 * desc asc
	 */
	private String sord;
	/**
	 * 查询字段
	 */
	private String searchFiled;
	/**
	 * 查询内容
	 */
	private String searchString;
	/**
	 * 查询操作
	 */
	private String searchOper;
	public boolean is_search() {
		return _search;
	}
	public void set_search(boolean _search) {
		this._search = _search;
	}
	public int getPage() {
		return page==0?1:page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows==0?10:rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSidx() {
		return sidx;
	}
	public void setSidx(String sidx) {
		this.sidx = sidx;
	}
	public String getSord() {
		return sord;
	}
	public void setSord(String sord) {
		this.sord = sord;
	}
	public String getSearchFiled() {
		return searchFiled;
	}
	public void setSearchFiled(String searchFiled) {
		this.searchFiled = searchFiled;
	}
	public String getSearchString() {
		return searchString;
	}
	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}
	public String getSearchOper() {
		return searchOper;
	}
	public void setSearchOper(String searchOper) {
		this.searchOper = searchOper;
	}
	
	
	
}
