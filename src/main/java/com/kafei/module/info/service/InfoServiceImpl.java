package com.kafei.module.info.service;

import com.kafei.mapper.InfoMapper;
import com.kafei.mapper.OpInfoMapper;
import com.kafei.mapper.StageMapper;
import com.kafei.mapper.VoteMapper;
import com.kafei.module.activity.service.ActivityService;
import com.kafei.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class InfoServiceImpl implements InfoService {

    @Autowired
    private InfoMapper mapper;
    @Autowired
    private StageMapper stageMapper;
    @Autowired
    private ActivityService activityService;
    @Autowired
    private VoteMapper voteMapper;
    @Autowired
    private OpInfoMapper opInfoMapper;

    @Override
    @Transactional
    public int deleteByPrimaryKey(Integer id) {
        voteMapper.deleteByInfoId(id);
        return mapper.deleteByPrimaryKey(id);
    }

    @Override
    @Transactional
    public int insertSelective(Info record, Integer voteId) {
        record.setOid(voteId);
        if (record.getOp().equals("投票")) {
            if (voteId != null && voteId != 0) {
                mapper.insertSelective(record);
                Vote vote = new Vote();
                vote.setId(voteId);
                vote.setInfoId(record.getId());
                return voteMapper.updateByPrimaryKeySelective(vote);
            }
        }
        if (record.getOp().equals("报名") || record.getOp().equals("意见")) {
            if (voteId != null && voteId != 0) {
                mapper.insertSelective(record);
                OpInfo vote = new OpInfo();
                vote.setId(voteId);
                vote.setInfoId(record.getId());
                return opInfoMapper.updateByPrimaryKeySelective(vote);
            }
        }
        if (record.getOp().equals("表决")) {
            mapper.insertSelective(record);
            String[] ids = record.getBjids().split(",");
            for (String id : ids) {
                OpInfo vote = new OpInfo();
                vote.setId(Integer.parseInt(id));
                vote.setInfoId(record.getId());
                opInfoMapper.updateByPrimaryKeySelective(vote);
            }
            return 1;
        }
        return mapper.insertSelective(record);
    }

    @Override
    public Info selectByPrimaryKey(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    @Transactional
    public int updateByPrimaryKeySelective(Info record, Integer voteId) {
        Info temp = mapper.selectByPrimaryKey(record.getId());
        //删除关联
        if (temp.getOid() != null) {
            if (temp.getOp().equals("投票")) {
                voteMapper.deleteInfoReltaion(temp.getOid());
            } else {
                opInfoMapper.deleteInfoReltaionByInfoId(record.getId());
            }
            mapper.deleteOpReltaion(record.getId());
        }
        record.setOid(voteId);
        if (record.getOp().equals("投票")) {
            if (voteId != null && voteId != 0) {
                Vote vote = new Vote();
                vote.setId(voteId);
                vote.setInfoId(record.getId());
                voteMapper.updateByPrimaryKeySelective(vote);
            }
        }
        if (record.getOp().equals("报名") || record.getOp().equals("意见")) {
            if (voteId != null && voteId != 0) {
                OpInfo vote = new OpInfo();
                vote.setId(voteId);
                vote.setInfoId(record.getId());
                opInfoMapper.updateByPrimaryKeySelective(vote);
            }
        }
        if (record.getOp().equals("表决")) {
            String[] ids = record.getBjids().split(",");
            for (String id : ids) {
                OpInfo vote = new OpInfo();
                vote.setId(Integer.parseInt(id));
                vote.setInfoId(record.getId());
                opInfoMapper.updateByPrimaryKeySelective(vote);
            }
        }
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Info> selectList(Info info) {
        return mapper.selectList(info);
    }

    @Override
    public List<Stage> selectStageList() {
        return stageMapper.selectList();
    }
}
