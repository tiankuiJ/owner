package com.kafei.mapper;

import com.kafei.vo.Manager;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface ManagerMapper {
    int deleteByPrimaryKey(Integer id);


    int insertSelective(Manager record);

    Manager selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Manager record);
    Manager login(Manager manager);

    List<Manager> selectList(Manager manager);

}