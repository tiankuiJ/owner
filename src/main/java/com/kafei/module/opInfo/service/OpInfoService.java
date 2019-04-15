package com.kafei.module.opInfo.service;

import com.kafei.vo.OpInfo;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2018/1/2.
 */
public interface OpInfoService {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(OpInfo record,Integer orgId, HttpServletRequest request) throws Exception;

    OpInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(OpInfo record);

    List<OpInfo> selectList(OpInfo opInfo);

    List<OpInfo> selectByIds(String ids);
}
