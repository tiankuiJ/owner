package com.kafei.module.org.service;

import com.kafei.mapper.OrgMapper;
import com.kafei.vo.Org;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgServiceImpl implements OrgService{
    @Autowired
    private OrgMapper mapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return mapper.deleteByPrimaryKey(id);
    }

    @Override
    public int insertSelective(Org record) {
        return mapper.insertSelective(record);
    }

    @Override
    public int falseDelete(Integer id) {
        mapper.deleteOwnerOrgByOwner(id);
        return mapper.falseDelete(id);
    }

    @Override
    public Org selectByPrimaryKey(Integer id) {
        return mapper.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(Org record) {
        return mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public List<Org> selectSheQu(Org org) {
        return mapper.selectSheQu(org);
    }

    @Override
    public List<Org> selectXiaoQu(Org org) {
        return mapper.selectXiaoQu(org);
    }
}
