package com.kafei.mapper;

import com.kafei.vo.Vote;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface VoteMapper {
    int deleteByPrimaryKey(Integer id);

    @Update("update o_vote set status='已删除' where info_id=#{infoId}")
    int deleteByInfoId(Integer infoId);

    @Update("update o_vote set info_id=null where id=#{id}")
    int deleteInfoReltaion(Integer id);

    int insertSelective(Vote record);

    Vote selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Vote record);

    List<Vote> selectList(Vote vote);

    Integer selectByInfoId(Integer infoId);

}