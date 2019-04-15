package com.kafei.mapper;

import com.kafei.vo.Owner;
import org.apache.ibatis.annotations.Select;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


public interface OwnerMapper {
    int deleteByPrimaryKey(Long phone);

    @Select("select id from o_owner where phone=#{phone}")
    Integer selectByPhone(String phone);

    int insertSelective(Owner record);

    @Transactional
    int insertBatch(List<Owner> list);

    Owner selectByPrimaryKey(Long phone);
    Owner selectById(Integer id);

    int updateByPrimaryKeySelective(Owner record);

    List<Owner> selectList(Owner owner);

    Owner webLogin(Owner owner);

    Double selectSumByOrgId(Integer id);
    @Select("select type from o_org where id=#{id}")
    String selectOrgTypeById(Integer id);

}