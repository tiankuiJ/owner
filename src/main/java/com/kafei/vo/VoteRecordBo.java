package com.kafei.vo;

import org.apache.ibatis.type.Alias;

@Alias("voteRecordBo")
public class VoteRecordBo {
    private String name;//候选人名称
    private String img;//候选人图片
    private Integer countAgreen=0;//同意票数
    private Integer countReject=0;//反对票数
    private Integer countGiveUp=0;//弃权票数
    private Double sumAgreen=0.0;//同意业主总面积
    private Double sumReject=0.0;//反对业主总面积
    private Double sumGiveUp=0.0;//弃权业主总面积

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getCountAgreen() {
        return countAgreen;
    }

    public void setCountAgreen(Integer countAgreen) {
        this.countAgreen = countAgreen;
    }

    public Integer getCountReject() {
        return countReject;
    }

    public void setCountReject(Integer countReject) {
        this.countReject = countReject;
    }

    public Integer getCountGiveUp() {
        return countGiveUp;
    }

    public void setCountGiveUp(Integer countGiveUp) {
        this.countGiveUp = countGiveUp;
    }

    public Double getSumAgreen() {
        return sumAgreen;
    }

    public void setSumAgreen(Double sumAgreen) {
        this.sumAgreen = sumAgreen;
    }

    public Double getSumReject() {
        return sumReject;
    }

    public void setSumReject(Double sumReject) {
        this.sumReject = sumReject;
    }

    public Double getSumGiveUp() {
        return sumGiveUp;
    }

    public void setSumGiveUp(Double sumGiveUp) {
        this.sumGiveUp = sumGiveUp;
    }
}
