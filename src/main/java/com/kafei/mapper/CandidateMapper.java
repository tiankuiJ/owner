package com.kafei.mapper;

import com.kafei.vo.Candidate;

import java.util.List;

public interface CandidateMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Candidate record);

    int insertSelective(Candidate record);

    Candidate selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Candidate record);

    int updateByPrimaryKey(Candidate record);

    List<Candidate> selectList(Candidate candidate);

    int updateNumBatch(List<Integer> list);
}