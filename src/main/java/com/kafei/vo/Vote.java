package com.kafei.vo;

import com.alibaba.fastjson.annotation.JSONField;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Alias("vote")
public class Vote extends SearchVo{
    private Integer id;

    private String title;

    private Integer infoId;

    private Integer maxUserVote;

    private String showNum;

    private String showRank;

    private String status;

    private Integer orgId;
    @JSONField(format = "yyyy-MM-dd")
    private Date startTime;
    @JSONField(format = "yyyy-MM-dd")
    private Date endTime;
    private Date createTime;

    private String orgName;

    private String infoName;

    private String content;

    private String qrCode;

    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
    }


    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getInfoName() {
        return infoName;
    }

    public void setInfoName(String infoName) {
        this.infoName = infoName;
    }

    public List<Org> getChildOrg() {
        return childOrg;
    }

    public void setChildOrg(List<Org> childOrg) {
        this.childOrg = childOrg;
    }

    private List<Org> childOrg;

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

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getInfoId() {
        return infoId;
    }

    public void setInfoId(Integer infoId) {
        this.infoId = infoId;
    }

    public Integer getMaxUserVote() {
        return maxUserVote;
    }

    public void setMaxUserVote(Integer maxUserVote) {
        this.maxUserVote = maxUserVote;
    }

    public String getShowNum() {
        return showNum;
    }

    public void setShowNum(String showNum) {
        this.showNum = showNum == null ? null : showNum.trim();
    }

    public String getShowRank() {
        return showRank;
    }

    public void setShowRank(String showRank) {
        this.showRank = showRank == null ? null : showRank.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
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