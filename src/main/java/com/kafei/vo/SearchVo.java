package com.kafei.vo;

import com.alibaba.fastjson.annotation.JSONField;

import java.util.Date;

public class SearchVo {
    private String searchStr;

    @JSONField(format = "yyyy-MM-dd")
    private Date currentDate=new Date();

    public Date getCurrentDate() {
        return currentDate;
    }

    public void setCurrentDate(Date currentDate) {
        this.currentDate = currentDate;
    }

    public String getSearchStr() {
        return searchStr;
    }

    public void setSearchStr(String searchStr) {
        this.searchStr = searchStr;
    }
}
