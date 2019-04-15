package com.kafei.module.activity.service;

import com.kafei.vo.Activity;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/12/18.
 */
public interface ActivityService {
    int deleteByPrimaryKey(Integer id);

    int insertSelective(Activity record, Integer orgId, HttpServletRequest request) throws Exception;

    Activity selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Activity record);

    List<Activity> selectList(Activity activity);
    int delete(Integer id);
}
