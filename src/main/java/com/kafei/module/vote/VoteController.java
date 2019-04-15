package com.kafei.module.vote;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.mapper.VoteRecordMapper;
import com.kafei.module.vote.service.VoteService;
import com.kafei.util.AjaxResult;
import com.kafei.util.DateUtils;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.vo.Candidate;
import com.kafei.vo.Manager;
import com.kafei.vo.Vote;
import com.kafei.vo.VoteRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@RequestMapping("vote")
@Controller
public class VoteController {
    @Autowired
    private VoteService service;
    @Autowired
    private VoteRecordMapper voteRecordMapper;

    @RequestMapping("listUI")
    public String listUI(){
        return "vote/list";
    }



    @RequestMapping("formUI")
    public String formUI(Integer id, Model model){
        if(id!=null){
            Vote vote = service.selectByPrimaryKey(id);
            model.addAttribute("m",vote);
            model.addAttribute("startTime", DateUtils.forMatDateWithNoTime(vote.getStartTime()));
            model.addAttribute("endTime",DateUtils.forMatDateWithNoTime(vote.getEndTime()));
            Candidate candidate = new Candidate();
            candidate.setVoteId(id);
            model.addAttribute("options",service.selectOptions(candidate));
            VoteRecord voteRecord = new VoteRecord();
            voteRecord.setVoteId(id);
            if(voteRecordMapper.selectList(voteRecord).size()>0)
                model.addAttribute("isBegin",true);
        }
        return "vote/form";
    }

    @RequestMapping("list")
    @ResponseBody
    public Object list(Vote vote, HttpServletRequest request, Pager pager){
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if(manager.getOrgType()!=null){
            if(manager.getOrgType().equals("社区")){
                vote.setChildOrg(manager.getChildOrg());
                vote.setOrgId(manager.getOrgId());
            }
            if(manager.getOrgType().equals("小区"))
                vote.setOrgId(manager.getOrgId());
        }
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectList(vote);
        return PageUtil.getResult(page);
    }

    @RequestMapping("add")
    @ResponseBody
    public AjaxResult add(Vote vote,String candidateStr,HttpServletRequest request) throws Exception {
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if(manager.getOrgId()!=null){
            vote.setOrgId(manager.getOrgId());
        }else{
            return AjaxResult.newInstance().doFail("投票信息只能由社区管理员和小区管理员添加");
        }

        ArrayList<Candidate> optionList = JSON.parseObject(candidateStr, new TypeReference<ArrayList<Candidate>>() {
        });
        service.insertSelective(vote,optionList,manager.getOrgId(),request);
        return AjaxResult.newInstance().doSuccess("添加成功");
    }

    @RequestMapping("update")
    @ResponseBody
    public AjaxResult update(Vote vote,String candidateStr,HttpServletRequest request){
        ArrayList<Candidate> optionList = JSON.parseObject(candidateStr, new TypeReference<ArrayList<Candidate>>() {
        });
        service.updateByPrimaryKeySelective(vote,optionList);
        return AjaxResult.newInstance().doSuccess("修改成功");
    }

    @RequestMapping("del")
    @ResponseBody
    public AjaxResult del(Integer id){
        return service.deleteByPrimaryKey(id)>0?AjaxResult.newInstance().doSuccess("删除成功"):AjaxResult.newInstance().doFail("删除失败");
    }

//    @RequestMapping("selectSumAcreageByVote")
//    @ResponseBody
//    public AjaxResult selectSumAcreageByVote(Integer voteId){
//
//    }


}
