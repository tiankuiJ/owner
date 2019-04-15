package com.kafei.module.ad.service;

import com.kafei.vo.Ad;

import java.util.List;

/**
 * Created by Administrator on 2017/12/25.
 */
public interface AdService {
    int deleteByPrimaryKey(Integer id);


    int insertSelective(Ad record);

    Ad selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Ad record);

    List<Ad> selectList(Ad ad);
}
