package com.kafei.vo;

import com.alibaba.fastjson.annotation.JSONField;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Alias("activity")
public class Activity extends SearchVo{
    private Integer id;

    private String title;

    private String img;

    private Integer orgId;

    private Integer userId;

    private String content;

    private String status;

    private List<Org> childOrg;

    private Integer viewNum;

    private String orgName;

    private String userName;
    @JSONField(format = "yyyy-MM-dd")
    private Date createTime;

    private String currentOp;

    private String qrCode;

    private Integer orgPid;

    public Integer getOrgPid() {
        return orgPid;
    }

    public void setOrgPid(Integer orgPid) {
        this.orgPid = orgPid;
    }

    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
    }

    public String getCurrentOp() {
        return currentOp;
    }

    public void setCurrentOp(String currentOp) {
        this.currentOp = currentOp;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public List<Org> getChildOrg() {
        return childOrg;
    }

    public void setChildOrg(List<Org> childOrg) {
        this.childOrg = childOrg;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img == null ? null : img.trim();
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}