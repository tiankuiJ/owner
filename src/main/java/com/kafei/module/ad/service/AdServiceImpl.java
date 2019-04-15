package com.kafei.module.ad.service;

import com.kafei.mapper.AdMapper;
import com.kafei.vo.Ad;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdServiceImpl implements AdService{
    @Autowired
    private AdMapper mapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return mapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insertSelective(Ad record) {
        return mapper.insertSelective(record);
    }

    @Override
    public Ad selectByPrimaryKey(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Ad record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Ad> selectList(Ad ad) {
        return mapper.selectList(ad);
    }
}
