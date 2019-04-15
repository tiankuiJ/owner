package com.kafei.vo;

import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

@Alias("owner")
public class Owner extends SearchVo{
    private Long phone;

    private Integer id;

    private String name;

    private String sex;

    private String birth;

    private String job;

    private String whcd;

    private String zzmm;

    private String position;

    private Double acreage;

    private Integer orgId;

    private Integer orgPId;

    private Date createTime;

    private String psd;

    private Integer deleted;

    private Long oldPhone;
    private String phonet;
    private String remark;

    private List<Org> childOrg;

    public List<Org> getChildOrg() {
        return childOrg;
    }

    public void setChildOrg(List<Org> childOrg) {
        this.childOrg = childOrg;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public Integer getOrgPId() {
        return orgPId;
    }

    public String getPhonet() {
        return phonet;
    }

    public void setPhonet(String phonet) {
        this.phonet = phonet;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setOrgPId(Integer orgPId) {
        this.orgPId = orgPId;
    }

    public Long getOldPhone() {
        return oldPhone;
    }

    public void setOldPhone(Long oldPhone) {
        this.oldPhone = oldPhone;
    }

    public String getPsd() {
        return psd;
    }

    public void setPsd(String psd) {
        this.psd = psd;
    }

    public Long getPhone() {
        return phone;
    }

    public void setPhone(Long phone) {
        this.phone = phone;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth == null ? null : birth.trim();
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job == null ? null : job.trim();
    }

    public String getWhcd() {
        return whcd;
    }

    public void setWhcd(String whcd) {
        this.whcd = whcd == null ? null : whcd.trim();
    }

    public String getZzmm() {
        return zzmm;
    }

    public void setZzmm(String zzmm) {
        this.zzmm = zzmm == null ? null : zzmm.trim();
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position == null ? null : position.trim();
    }

    public Double getAcreage() {
        return acreage;
    }

    public void setAcreage(Double acreage) {
        this.acreage = acreage;
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

    public Owner(Long phone) {
        this.phone = phone;
    }

    public Owner() {
    }
}