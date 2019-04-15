package com.kafei.vo;

import com.alibaba.fastjson.annotation.JSONField;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Alias("opInfo")
public class OpInfo extends SearchVo{
    private Integer id;

    private String title;

    private String video;

    private Integer orgId;

    private String orgName;

    private Integer infoId;

    private String infoName;

    private String desct;

    public String getDesct() {
        return desct;
    }

    public void setDesct(String desct) {
        this.desct = desct;
    }

    public String getInfoName() {
        return infoName;
    }

    public void setInfoName(String infoName) {
        this.infoName = infoName;
    }
    @JSONField(format = "yyyy-MM-dd")
    private Date startTime;
    @JSONField(format = "yyyy-MM-dd")
    private Date endTime;

    private Date createTime;

    private String type;

    private String content;

    private Integer viewNum;

    private List<Org> childOrg;

    private String qrCode;

    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
    }


    public Integer getViewNum() {
        return viewNum;
    }

    public void setViewNum(Integer viewNum) {
        this.viewNum = viewNum;
    }

    public Integer getInfoId() {
        return infoId;
    }

    public void setInfoId(Integer infoId) {
        this.infoId = infoId;
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

    public String getTitle() {
        return title;
    }

    public List<Org> getChildOrg() {
        return childOrg;
    }

    public void setChildOrg(List<Org> childOrg) {
        this.childOrg = childOrg;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video == null ? null : video.trim();
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}