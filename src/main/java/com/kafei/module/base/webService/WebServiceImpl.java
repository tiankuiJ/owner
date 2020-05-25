package com.kafei.module.base.webService;

import com.alibaba.fastjson.JSON;
import com.kafei.mapper.*;
import com.kafei.util.AESUtil;
import com.kafei.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class WebServiceImpl implements WebService{
    @Autowired
    private OwnerMapper ownerMapper;
    @Autowired
    private OrgMapper orgMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private AdMapper adMapper;
    @Autowired
    private InfoMapper infoMapper;
    @Autowired
    private RegRecordMapper regRecordMapper;
    @Autowired
    private VoteMapper voteMapper;
    @Autowired
    private VoteRecordMapper voteRecordMapper;
    @Autowired
    private CandidateMapper candidateMapper;
    @Autowired
    private StageMapper stageMapper;
    @Autowired
    private OpInfoMapper opInfoMapper;
    @Override
    public Owner login(Owner owner, HttpServletRequest request) {
        if(owner.getPsd()==null)
            return null;
        System.out.println(JSON.toJSONString(owner));
        if((owner = ownerMapper.webLogin(owner))!=null){
//            Org org = orgMapper.selectByPrimaryKey(owner.getOrgId());
//            owner.setOrgPId(org.getId());
            WebUtils.setSessionAttribute(request,"ownerSession",owner);
            return owner;
        }
        return null;
    }

    @Override
    public Owner loginById(Owner owner, HttpServletRequest request) {
        owner = ownerMapper.selectByPrimaryKey(owner.getPhone());
        Org org = orgMapper.selectByPrimaryKey(owner.getOrgId());
        owner.setOrgPId(org.getId());
        WebUtils.setSessionAttribute(request,"ownerSession",owner);
        return owner;
    }
    @Override
    public List<Activity> activityList(Activity activity){
        List<Activity> list = activityMapper.webSelectList(activity);
        return list;
    }

    @Override
    public List<Activity> webActivityList(Activity activity) {
        return activityMapper.webSelectList(activity);
    }

    @Override
    public List<Vote> voteList(Vote activity) {
        return voteMapper.selectList(activity);
    }

    @Override
    public List<OpInfo> opInfoList(OpInfo activity) {
        return opInfoMapper.selectList(activity);
    }

    @Override
    public List<Ad> adList(Ad ad) {
        return adMapper.webSelectList(ad);
    }

    @Override
    public Object infoList(Info info) {
        activityMapper.updateViewNum(info.getActivityId());
        List<Stage> stagelist = stageMapper.selectList();
        List<Object> result = new ArrayList<>();
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            now= simpleDateFormat.parse(simpleDateFormat.format(now));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        for(Stage stage:stagelist){
            Map<String,Object> map = new HashMap<>();
            map.put("stage",stage);
            info.setStageId(stage.getId());
            List<Info> list = infoMapper.webSelectList(info);
//            for(Info temp:list){
//                if(!(!temp.getStartTime().after(now) && !temp.getEndTime().before(now))){
//                    temp.setOp("无");
//                }
//            }
            if(list.size()>0){
                map.put("infoList",list);
                result.add(map);
            }else{
                map.remove("stage");
            }
        }
        return result;
    }

    @Override
    public Object opInfoList(Info info) {
        List<Stage> stagelist = stageMapper.selectList();
        List<Object> result = new ArrayList<>();
        Date now = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            now= simpleDateFormat.parse(simpleDateFormat.format(now));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        info.setStartTime(now);
        for(Stage stage:stagelist){
            Map<String,Object> map = new HashMap<>();
            map.put("stage",stage);
            info.setStageId(stage.getId());
            info.setOp("a");
            List<Info> list = infoMapper.webSelectList(info);
            if(list.size()>0){
                map.put("infoList",list);
                result.add(map);
            }else{
                map.remove("stage");
            }

        }
        return result;
    }

    @Override
    public Info infoDetail(Integer infoId) {
        infoMapper.updateViewNum(infoId);
        return infoMapper.selectByPrimaryKey(infoId);
    }

    @Override
    public int regInfo(RegRecord regRecord) {
        List<RegRecord> list = regRecordMapper.selectList(regRecord);
        if(list.size()>0)
            return -1;
        Integer opId = regRecord.getOpId();
        OpInfo opInfo = opInfoMapper.selectByPrimaryKey(opId);
        String userId = regRecord.getUserId();
        Org org = orgMapper.selectByPrimaryKey(opInfo.getOrgId());
        if(!checkRegPermission(org,Integer.parseInt(userId))){
            return -2;
        }
        return regRecordMapper.insertSelective(regRecord);
    }


    private boolean checkRegPermission(Org org,Integer userId){
        List<Integer> allOrgIds = ownerMapper.selectAllOrgIdByUserId((userId));
        if(org.getType().equals("小区")){
            return allOrgIds.contains(org.getId());
        }else{
            List<Integer> ids = orgMapper.selectIdsByPid(org.getId());
            for (int i = 0; i < ids.size(); i++) {
                if(allOrgIds.contains(ids.get(i))){
                    return true;
                }
            }
            return false;
        }
    }

    @Override
    public int batchRegBiaoJue(List<RegRecord> regRecord,Integer userId) {
        for(RegRecord record:regRecord){
            record.setUserId(String.valueOf(userId));
            List<RegRecord> list = regRecordMapper.selectList(record);
            if(list.size()>0)
                return -1;
        }


        Integer opId = regRecord.get(0).getOpId();
        OpInfo opInfo = opInfoMapper.selectByPrimaryKey(opId);
        Org org = orgMapper.selectByPrimaryKey(opInfo.getOrgId());
        if(!checkRegPermission(org,userId)){
            return -2;
        }
        for(RegRecord record:regRecord){
            regRecordMapper.insertSelective(record);
        }
        return 1;
    }

    @Override///
    public Object voteInfo(Integer id) {
        Map<String,Object> map = new HashMap<>();
        Vote vote = voteMapper.selectByPrimaryKey(id);
        map.put("vote",vote);
        Candidate candidate = new Candidate();
        candidate.setVoteId(vote.getId());
        map.put("options",candidateMapper.selectList(candidate));
        return map;
    }

    @Override
    @Transactional(isolation = Isolation.SERIALIZABLE,rollbackFor = Exception.class)
    public int regVote(List<VoteRecord> records,String phone) {


        if(records==null)
            return 0;

        Integer ownerId = ownerMapper.selectByPhone(phone);
        if(ownerId==null)
            return -2;
        Integer opId = records.get(0).getVoteId();
        Vote opInfo = voteMapper.selectByPrimaryKey(opId);
        Org org = orgMapper.selectByPrimaryKey(opInfo.getOrgId());
        if(!checkRegPermission(org,ownerId)){
            return -2;
        }


        VoteRecord voteRecord = new VoteRecord();
        voteRecord.setUserId(phone);
        voteRecord.setVoteId(records.get(0).getVoteId());
        List<Integer> list = voteRecordMapper.checkIsVote(voteRecord);
        if(list!=null && list.size()>0)
            return -1;
        List<Integer> cid = new ArrayList<>();
        for(VoteRecord record:records){
            record.setUserId(phone);
            if(record.getChoice().equals("同意")){
                cid.add(record.getCaId());
            }
        }
        if(cid.size()>0)
            candidateMapper.updateNumBatch(cid);
        return voteRecordMapper.insertBatch(records);
    }

    @Override
    public OpInfo opInfoDetail(Integer id) {
        return opInfoMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<OpInfo> biaoJueList(Integer infoId) {
        return opInfoMapper.biaoJueList(infoId);
    }

    @Override
    public Object biaojueDetails(Integer infoId) {
        Map<String,Object> map = new HashMap<>();
        Info info = infoMapper.selectByPrimaryKey(infoId);
        map.put("info",info);
        String[] ids = info.getBjids().split(",");
        List<OpInfo> opInfoList = new ArrayList<>();
        for(int i=0;i<ids.length;i++){
            OpInfo opInfo = opInfoMapper.selectByPrimaryKey(Integer.parseInt(ids[i]));
            opInfoList.add(opInfo);
        }
        map.put("opInfoList",opInfoList);
        return map;
    }
}
