package com.kafei.vo;

import com.alibaba.fastjson.annotation.JSONField;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Alias("ad")
public class Ad extends SearchVo{
    private Integer id;

    private String position;

    private String img;

    private String url;

    private String status;

    private Date createTime;
    @JSONField(format = "yyyy-MM-dd")
    private Date startTime;
    @JSONField(format = "yyyy-MM-dd")
    private Date endTime;

    private String title;

    private Integer weight;

    private Integer orgId;
    private List<Org> childOrg;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public Date getStartTime() {
        return startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public List<Org> getChildOrg() {
        return childOrg;
    }

    public void setChildOrg(List<Org> childOrg) {
        this.childOrg = childOrg;
    }

    public Integer getOrgId() {
        return orgId;
    }

    public void setOrgId(Integer orgId) {
        this.orgId = orgId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position == null ? null : position.trim();
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img == null ? null : img.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}