package com.kafei.mapper;

import com.kafei.vo.Activity;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface ActivityMapper {
    int deleteByPrimaryKey(Integer id);
    @Update("update o_activity set del=1 where id=#{id}")
    int delete(Integer id);

    int insertSelective(Activity record);

    Activity selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Activity record);

    List<Activity> selectList(Activity activity);
    List<Activity> webSelectList(Activity activity);

    @Update("update o_activity set view_num=view_num+1 where id=#{id}")
    int updateViewNum(Integer id);

}