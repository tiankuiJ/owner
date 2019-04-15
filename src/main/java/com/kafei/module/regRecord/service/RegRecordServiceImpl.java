package com.kafei.module.regRecord.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.mapper.RegRecordMapper;
import com.kafei.mapper.VoteMapper;
import com.kafei.mapper.VoteRecordMapper;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.vo.BiaojueUserCountBo;
import com.kafei.vo.RegRecord;
import com.kafei.vo.RegRecordKey;
import com.kafei.vo.VoteRecordBo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RegRecordServiceImpl implements RegRecordService{

    @Autowired
    private RegRecordMapper mapper;
    @Autowired
    private VoteRecordMapper voteRecordMapper;
    @Autowired
    private VoteMapper voteMapper;
    @Override
    public int deleteByPrimaryKey(RegRecordKey key) {
        return mapper.deleteByPrimaryKey(key);
    }

    @Override
    public int insertSelective(RegRecord record) {
        return mapper.insertSelective(record);
    }

    @Override
    public RegRecord selectByPrimaryKey(RegRecord key) {
        return mapper.selectByPrimaryKey(key);
    }

    @Override
    public int updateByPrimaryKeySelective(RegRecord record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<RegRecord> selectList(RegRecord regRecord) {
        return mapper.selectList(regRecord);
    }

    @Override
    public Object selectVoteRecordList(Integer voteId,Pager pager) {
//        Integer voteId = voteMapper.selectByInfoId(infoId);
//        if(voteId==null)
//            return null;
        Page<Object> page;
        if(StringUtils.isBlank(pager.getSidx())){
            page = PageHelper.startPage(pager.getPage(), pager.getRows());
        }else{
            page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        }
        voteRecordMapper.selectVoteRecordList(voteId);
        return PageUtil.getResult(page);
    }
    @Override
    public List<VoteRecordBo>  selectVoteRecordList(Integer voteId) {
        return  voteRecordMapper.selectVoteRecordListNoPage(voteId);
    }

    @Override
    public BiaojueUserCountBo selectBioaJueUserCount(RegRecord regRecord) {
        return mapper.selectBioaJueUserCount(regRecord);
    }
}
