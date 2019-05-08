package com.kafei.module.regRecord;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.mapper.RegRecordMapper;
import com.kafei.mapper.VoteMapper;
import com.kafei.mapper.VoteRecordMapper;
import com.kafei.module.regRecord.service.RegRecordService;
import com.kafei.util.AjaxResult;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.vo.RegRecord;
import com.kafei.vo.RegRecordKey;
import com.kafei.vo.Vote;
import com.kafei.vo.VoteRecordBo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("regRecord")
@Controller
public class RegRecordController {

    @Autowired
    private RegRecordService service;
    @Autowired
    private RegRecordMapper mapper;
    @Autowired
    private VoteRecordMapper voteRecordMapper;

    @RequestMapping("listUI")
    public String listUI(){
        return "activity/regRecord";
    }

    @RequestMapping("voteRecordListUI")
    public String voteRecordListUI(){
        return "activity/voteRecord";
    }


    @RequestMapping("regRecordList")
    @ResponseBody
    public Object regRecordList(RegRecord key, Pager pager){
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectList(key);
        return PageUtil.getResult(page);
    }

    @RequestMapping("regRecordDetail")
    @ResponseBody
    public AjaxResult regRecordDetail(RegRecord key){
        return AjaxResult.newInstance().doSuccess("查询成功",service.selectByPrimaryKey(key));
    }

    @RequestMapping("selectSumAcreageByInfo")
    @ResponseBody
    public AjaxResult selectSumAcreageByInfo(RegRecord regRecord){
        Double result = mapper.selectSumAcreageByInfo(regRecord);
        if(result==null)
            result=0.0;
        return AjaxResult.newInstance().doSuccess("查询成功",result);
    }

    @RequestMapping("selectAcreageBiaoJue")
    @ResponseBody
    public  AjaxResult selectAcreageBiaoJue(RegRecord regRecord){
        List<RegRecord> result = mapper.selectAcreageBiaoJue(regRecord);
        return AjaxResult.newInstance().doSuccess("查询成功",result);
    }
@Autowired
private VoteMapper voteMapper;
    @RequestMapping("resultUI")
    public String resulUI(Integer voteId, Model model){
        List<VoteRecordBo> optionList = service.selectVoteRecordList(voteId);
        model.addAttribute("optionList",optionList);
        List<Long> list = voteRecordMapper.selectVoreRecordUser(voteId);
        if(list.size()==0){
            model.addAttribute("joinSumAcreage",0);
        }else{
            Vote vote = voteMapper.selectByPrimaryKey(voteId);
            Map<String,Object> map = new HashMap<>();
            map.put("list",list);
            map.put("orgId",vote.getOrgId());
            Double result = voteRecordMapper.sumAcreageByUserIdsAndOrgId(map);
            model.addAttribute("joinSumAcreage",result);
        }
        return "activity/voteResult";
    }

    @RequestMapping("selectVoteRecordList")
    @ResponseBody
    public Object selectVoteRecordList(Integer voteId,Pager pager){
        Object result = service.selectVoteRecordList(voteId, pager);
        return result;
    }

    @RequestMapping("selectBioaJueUserCount")
    @ResponseBody
    public AjaxResult selectBioaJueUserCount(RegRecord regRecord){
        return AjaxResult.newInstance().doSuccess("ok",service.selectBioaJueUserCount(regRecord));
    }
}
