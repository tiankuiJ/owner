package com.kafei.vo;

import org.apache.ibatis.type.Alias;

@Alias("biaojueUserCountBo")
public class BiaojueUserCountBo {

    private Integer agreenUserCount;
    private Integer rejectUserCount;
    private Integer giveUpUserCount;
    private Integer userCount;

    public Integer getAgreenUserCount() {
        return agreenUserCount;
    }

    public void setAgreenUserCount(Integer agreenUserCount) {
        this.agreenUserCount = agreenUserCount;
    }

    public Integer getRejectUserCount() {
        return rejectUserCount;
    }

    public void setRejectUserCount(Integer rejectUserCount) {
        this.rejectUserCount = rejectUserCount;
    }

    public Integer getGiveUpUserCount() {
        return giveUpUserCount;
    }

    public void setGiveUpUserCount(Integer giveUpUserCount) {
        this.giveUpUserCount = giveUpUserCount;
    }

    public Integer getUserCount() {
        return userCount;
    }

    public void setUserCount(Integer userCount) {
        this.userCount = userCount;
    }
}
