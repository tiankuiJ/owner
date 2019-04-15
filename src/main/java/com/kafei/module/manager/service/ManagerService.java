package com.kafei.module.manager.service;

import com.alibaba.fastjson.JSONObject;
import com.kafei.vo.Manager;
import com.kafei.vo.Owner;

import java.io.InputStream;
import java.util.List;

/**
 * Created by Administrator on 2017/12/15.
 */
public interface ManagerService {

    int deleteByPrimaryKey(Integer id);


    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Manager record);
    Manager login(Manager manager);

    List<Manager> selectList(Manager manager);

    List<Owner> selectOwnerList(Owner owner);

    int insertOwner(Owner owner);

    int updateOwner(Owner owner);

    JSONObject importOwner(InputStream in, String fileName,Integer orgId);
}
