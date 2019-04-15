package com.kafei.module.regRecord.service;

import com.kafei.util.Pager;
import com.kafei.vo.BiaojueUserCountBo;
import com.kafei.vo.RegRecord;
import com.kafei.vo.RegRecordKey;
import com.kafei.vo.VoteRecordBo;

import java.util.List;

/**
 * Created by Administrator on 2017/12/21.
 */
public interface RegRecordService {
    int deleteByPrimaryKey(RegRecordKey key);


    int insertSelective(RegRecord record);

    RegRecord selectByPrimaryKey(RegRecord key);

    int updateByPrimaryKeySelective(RegRecord record);

    List<RegRecord> selectList(RegRecord regRecord);

    Object selectVoteRecordList(Integer infoId,Pager pager);

    List<VoteRecordBo>  selectVoteRecordList(Integer infoId);

    BiaojueUserCountBo selectBioaJueUserCount(RegRecord regRecord);
}
