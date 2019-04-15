package com.kafei.mapper;

import com.kafei.vo.Info;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface InfoMapper {
    int deleteByPrimaryKey(Integer id);


    int insertSelective(Info record);

    Info selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Info record);

    List<Info> selectList(Info info);
    List<Info> webSelectList(Info info);
    @Update("update o_info set view_num=view_num+1 where id=#{id}")
    int updateViewNum(Integer id);

    @Update("update o_info set oid=null,op='无',bjids=null where id=#{id}")
    int deleteOpReltaion(Integer id);

}