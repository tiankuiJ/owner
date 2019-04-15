package com.kafei.module.info.service;

import com.kafei.vo.Info;
import com.kafei.vo.Stage;

import java.util.List;

/**
 * Created by Administrator on 2017/12/19.
 */
public interface InfoService {
    int deleteByPrimaryKey(Integer id);


    int insertSelective(Info record,Integer voteId);

    Info selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Info record,Integer voteId);

    List<Info> selectList(Info info);

    List<Stage> selectStageList();

}
