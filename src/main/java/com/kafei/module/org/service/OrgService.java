package com.kafei.module.org.service;

import com.kafei.vo.Org;

import java.util.List;

/**
 * Created by Administrator on 2017/12/15.
 */
public interface OrgService {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(Org record);

    int falseDelete(Integer id);

    Org selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Org record);

    List<Org> selectSheQu(Org org);

    List<Org> selectXiaoQu(Org org);
}
