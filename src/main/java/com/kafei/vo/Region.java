package com.kafei.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 公司名称：四川咖菲科技有限公司
 * 联系电话： 13398376166
 * 联系人： 陈德强
 * 邮箱：200751119@qq.com
 * 微信号： mycdq168
 * 地址：四川省绵阳市创新中心二期412
 * 官方网站 : http://www.kafeikeji.com/
 * 微信公众号： 咖啡科技
 * 项目名称：党建
 * 类名称：区域
 * 类描述：   
 * 创建人：蒋莲
 * 创建时间： 2017年3月8日
 * 修改人：
 * 修改时间：
 * 修改备注：   
 * @version 1.0   
 */
public class Region implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 4991318396506956512L;

	private Long id;

    private Long code;

    private Long parentid;

    private String name;

    private Integer level;
    
    private List<Region> children;
    private Boolean isRoot = Boolean.FALSE;
    
    private Integer childSize;
    
    public Integer getChildSize() {
		return childSize = (childSize==null?0:childSize);
	}

	public void setChildSize(Integer childSize) {
		this.childSize=childSize;
	}

	public List<Region> getChildren() {
    	if (children == null) {
            children = new ArrayList<Region>();
        }
        return children;
	}

	public void setChildren(List<Region> children) {
		this.children = children;
	}
	/**
     * @return
     */
    public boolean isHasChildren() {
        return !getChildren().isEmpty();
    }

	public Boolean getIsRoot() {
		return isRoot;
	}

	public void setIsRoot(Boolean isRoot) {
		this.isRoot = isRoot;
	}

	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCode() {
        return code;
    }

    public void setCode(Long code) {
        this.code = code;
    }

    public Long getParentid() {
        return parentid;
    }

    public void setParentid(Long parentid) {
        this.parentid = parentid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

	public Region(Long id, Long code, Long parentid, String name) {
		super();
		this.id = id;
		this.code = code;
		this.parentid = parentid;
		this.name = name;
	}
	public Region() {
		super();
	}
    
    
}