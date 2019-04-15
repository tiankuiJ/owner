package com.kafei.module.base.webService;

import com.kafei.vo.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2017/12/26.
 */
public interface WebService {
    Owner login(Owner owner, HttpServletRequest request);
    Owner loginById(Owner owner, HttpServletRequest request);
     List<Activity> activityList(Activity activity);
     List<Activity> webActivityList(Activity activity);
     List<Vote> voteList(Vote activity);
     List<OpInfo> opInfoList(OpInfo activity);
     List<Ad> adList(Ad ad);
     Object infoList(Info info);
     Object opInfoList(Info info);
     Info infoDetail(Integer infoId);
     int regInfo(RegRecord regRecord);
     int batchRegBiaoJue(List<RegRecord> regRecord,Integer userId);


     Object voteInfo(Integer infoId);
     int regVote(List<VoteRecord> records,String phone);
     OpInfo opInfoDetail(Integer id);
    List<OpInfo> biaoJueList(Integer infoId);

    Object biaojueDetails(Integer infoId);


}
