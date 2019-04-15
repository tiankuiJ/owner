package com.kafei.mapper;

import com.kafei.vo.OpInfo;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface OpInfoMapper {
    int deleteByPrimaryKey(Integer id);

    @Update("update o_op_info set view_num=view_num+1 where id=#{id}")
    int updateViewNum(Integer id);

    @Update("update o_op_info set info_id=null where id=#{id}")
    int deleteInfoReltaion(Integer id);

    @Update("update o_op_info set info_id=null where info_id=#{id}")
    int deleteInfoReltaionByInfoId(Integer id);

    int insertSelective(OpInfo record);

    OpInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OpInfo record);

    List<OpInfo> selectList(OpInfo opInfo);
    List<OpInfo> biaoJueList(Integer infoId);

    List<OpInfo> selectByIds(List<Integer> list);

}