package com.kafei.mapper;

import com.kafei.vo.Ad;

import java.util.List;

public interface AdMapper {
    int deleteByPrimaryKey(Integer id);


    int insertSelective(Ad record);

    Ad selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Ad record);

    List<Ad> selectList(Ad ad);
    List<Ad> webSelectList(Ad ad);

}