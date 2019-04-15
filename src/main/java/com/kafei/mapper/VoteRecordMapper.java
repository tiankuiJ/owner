package com.kafei.mapper;

import com.kafei.vo.VoteRecord;
import com.kafei.vo.VoteRecordBo;
import com.kafei.vo.VoteRecordKey;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface VoteRecordMapper {
    int deleteByPrimaryKey(VoteRecordKey key);

    int insert(VoteRecord record);

    int insertSelective(VoteRecord record);

    VoteRecord selectByPrimaryKey(VoteRecordKey key);

    int updateByPrimaryKeySelective(VoteRecord record);

    int updateByPrimaryKey(VoteRecord record);

    List<VoteRecord> selectList(VoteRecord record);

    List<VoteRecordBo> selectVoteRecordList(Integer voteId);

    List<VoteRecordBo> selectVoteRecordListNoPage(Integer voteId);
    @Select("select id from o_vote_record where vote_id=#{voteId} and user_id=#{userId}")
    List<Integer> checkIsVote(VoteRecord record);

    int insertBatch(List<VoteRecord> list);

    @Select("SELECT  user_id FROM o_vote_record WHERE vote_id=#{voteId} GROUP BY  user_id")
    List<Long> selectVoreRecordUser(Integer voteId);

    Double sumAcreageByUserIds(List<Long> list);
}