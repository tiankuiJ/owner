package com.kafei.mapper;

import com.kafei.vo.Owner;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;


public interface OwnerMapper {
    int deleteByPrimaryKey(Long phone);

    @Select("select id from o_owner where phone=#{phone}")
    Integer selectByPhone(String phone);


    List<Map<String,Object>> selectOwnerOrgList(Owner owner);

    int updateOwnerOrg(Owner owner);
    int insertOwnerOrg(Owner owner);

    int deleteOwnerOrg(Integer id);

    int insertSelective(Owner record);

    int insertOwnerOrgBatch(List<Owner> list);

    Owner selectByPrimaryKey(Long phone);
    Owner selectById(Integer id);

    int updateByPrimaryKeySelective(Owner record);

    List<Owner> selectList(Owner owner);

    Owner webLogin(Owner owner);

    Double selectSumByOrgId(Integer id);
    @Select("select type from o_org where id=#{id}")
    String selectOrgTypeById(Integer id);
    @Select("select count(id) from o_owner_org where org_id=#{orgId} and position=#{position} and user_id=#{userId}")
    int checkOwnerOrg(@Param("orgId") Integer orgId,@Param("position") String position,@Param("userId") Integer userId);
    @Select("select distinct org_id from o_owner_org where user_id=#{userId}")
    List<Integer> selectAllOrgIdByUserId(@Param("userId") Integer userId);

}