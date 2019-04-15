package com.kafei.vo;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Menu implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = -8251415309835133504L;
	private Long id;
    private String text;
    private Long code;
    //返回角色列表时使用
    private Long siteId;
    private String url;
    private List<Menu> children;
    private Long pid;
    private String icon;
    private String detail;
    private String isAdmin;
    private  String state;
    private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public Long getSiteId() {
		return siteId;
	}

	public void setSiteId(Long siteId) {
		this.siteId = siteId;
	}

	private Boolean isRoot = Boolean.FALSE;
    
    public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public Boolean getIsRoot() {
		return isRoot;
	}

	public void setIsRoot(Boolean isRoot) {
		this.isRoot = isRoot;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<Menu> getChildren() {
        if (children == null) {
            children = new ArrayList<Menu>();
        }
        return children;
    }

    public void setChildren(List<Menu> children) {
        this.children = children;
    }

    /**
     * @return
     */
    public boolean isHasChildren() {
        return !getChildren().isEmpty();
    }
    
    
	public Long getCode() {
		return code;
	}

	public void setCode(Long code) {
		this.code = code;
	}

	/**
	 * 资源
	 */
	public Menu(Long id, String text, String url,
                Long parentId, String icon, String isAdmin) {
		super();
		this.id = id;
		this.text = text;
		this.url = url;
		this.pid = parentId;
		this.icon = icon;
		this.isAdmin=isAdmin;
	}

	public Menu() {
		super();
	}

	public Menu(Long id, String text, Long parentId, String type) {
		super();
		this.id = id;
		this.text = text;
		this.pid = parentId;
		this.type = type;
	}
	
	public Menu(Long id, String text, Long parentId, String detail, Long siteId) {
		super();
		this.id = id;
		this.text = text;
		this.pid = parentId;
		this.detail = detail;
		this.siteId = siteId;
	}

	public Menu(Long id, Long code , String text, Long parentId) {
		super();
		this.id = id;
		this.code = code;
		this.text = text;
		this.pid = parentId;
	}

	/**
	 * 地区
	 */
	public Menu(Long id, String text, String state) {
		super();
		this.id = id;
		this.text = text;
		this.state = state;
	}
   
	
}
