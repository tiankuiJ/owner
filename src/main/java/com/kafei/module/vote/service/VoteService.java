package com.kafei.module.vote.service;

import com.kafei.vo.Candidate;
import com.kafei.vo.Vote;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/12/20.
 */
public interface VoteService {
    int deleteByPrimaryKey(Integer id);


    int insertSelective(Vote record, List<Candidate> candidates,Integer orgId, HttpServletRequest request) throws Exception;

    Vote selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Vote record, List<Candidate> candidates);

    List<Vote> selectList(Vote vote);

    List<Candidate> selectOptions(Candidate candidate);

}
