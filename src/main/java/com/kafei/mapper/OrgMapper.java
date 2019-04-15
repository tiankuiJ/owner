package com.kafei.mapper;

import com.kafei.vo.Org;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface OrgMapper {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(Org record);
    @Update("update o_owner set deleted=1 where id=#{id}")
    int falseDelete(Integer id);

    Org selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Org record);

    List<Org> selectSheQu(Org org);

    List<Org> selectXiaoQu(Org org);

    List<Integer> selectIdsByPid(Integer pId);


}