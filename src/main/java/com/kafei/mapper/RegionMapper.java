package com.kafei.mapper;



import com.kafei.vo.Region;

import java.util.List;

public interface RegionMapper {
    List<Region> getAll();
    List<Region> getListByPid(Long pid);
    List<Region> getListByPidWithSelf(Long pid);
    String getNameById(Long id);
}