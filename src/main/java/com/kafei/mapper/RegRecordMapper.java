package com.kafei.mapper;

import com.kafei.vo.BiaojueUserCountBo;
import com.kafei.vo.RegRecord;
import com.kafei.vo.RegRecordKey;

import java.util.List;

public interface RegRecordMapper {
    int deleteByPrimaryKey(RegRecordKey key);


    int insertSelective(RegRecord record);

    RegRecord selectByPrimaryKey(RegRecord key);

    int updateByPrimaryKeySelective(RegRecord record);

    List<RegRecord> selectList(RegRecord regRecord);
    //根据信息查询参加人员的总面积
    Double selectSumAcreageByInfo(RegRecord regRecord);
    //查询表决信息参加人员面积(分组)
    List<RegRecord> selectAcreageBiaoJue(RegRecord regRecord);

    BiaojueUserCountBo selectBioaJueUserCount(RegRecord regRecord);


}