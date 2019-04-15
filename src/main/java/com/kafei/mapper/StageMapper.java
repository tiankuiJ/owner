package com.kafei.mapper;

import com.kafei.vo.Stage;

import java.util.List;

public interface StageMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Stage record);

    int insertSelective(Stage record);

    Stage selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Stage record);

    int updateByPrimaryKey(Stage record);

    List<Stage> selectList();
}