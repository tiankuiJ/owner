package com.kafei.mapper;

import com.kafei.vo.Org;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface OrgMapper {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(Org record);
    @Delete("delete from o_owner where id=#{id}")
    int falseDelete(Integer id);
    @Delete("delete from o_owner_org where user_id=#{userId}")
    int deleteOwnerOrgByOwner(Integer userId);

    Org selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Org record);

    List<Org> selectSheQu(Org org);

    List<Org> selectXiaoQu(Org org);

    List<Integer> selectIdsByPid(Integer pId);


}