package com.kafei.vo;

import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Alias("manager")
public class Manager extends  SearchVo{
    private Integer id;

    private String account;

    private String psd;

    private Integer orgId;

    private Date createTime;

    private String orgName;
    private String name;
    private List<Org> childOrg;

    private String orgType;

    public List<Org> getChildOrg() {
        return childOrg;
    }

    public void setChildOrg(List<Org> childOrg) {
        this.childOrg = childOrg;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOrgType() {
        return orgType;
    }

    public void setOrgType(String orgType) {
        this.orgType = orgType;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getPsd() {
        return psd;
    }

    public void setPsd(String psd) {
        this.psd = psd == null ? null : psd.trim();
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}