package com.kafei.module.info;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.mapper.StageMapper;
import com.kafei.module.info.service.InfoService;
import com.kafei.util.AjaxResult;
import com.kafei.util.DateUtils;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.vo.Info;
import com.kafei.vo.Stage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("info")
public class InfoController {

    @Autowired
    private InfoService service;
    @Autowired
    private StageMapper stageMapper;

    @RequestMapping("listUI")
    public String listUI(){
        return "activity/infoList";
    }

    @RequestMapping("stageListUI")
    public String stageListUI(){
        return "activity/stage";
    }

    @RequestMapping("formUI")
    public String formUI(Integer id, Model model){
        if(id!=null){
            Info info = service.selectByPrimaryKey(id);
            model.addAttribute("m",info);
            if(info.getStartTime()!=null)
                model.addAttribute("startTime", DateUtils.forMatDateWithNoTime(info.getStartTime()));
            if(info.getEndTime()!=null)
                model.addAttribute("endTime", DateUtils.forMatDateWithNoTime(info.getEndTime()));
        }
        return "activity/infoForm";

    }

    @RequestMapping("add")
    @ResponseBody
    public AjaxResult add(Info info,HttpServletRequest request,Integer voteId){
        return service.insertSelective(info,voteId)>0?AjaxResult.newInstance().doSuccess("发布成功"):AjaxResult.newInstance().doFail("发布失败");
    }

    @RequestMapping("del")
    @ResponseBody
    public AjaxResult del(Integer id){
        return service.deleteByPrimaryKey(id)>0?AjaxResult.newInstance().doSuccess("删除成功"):AjaxResult.newInstance().doFail("删除失败");
    }

    @RequestMapping("update")
    @ResponseBody
    public AjaxResult update(Info info,HttpServletRequest request,Integer voteId){
        return service.updateByPrimaryKeySelective(info,voteId)>0?AjaxResult.newInstance().doSuccess("修改成功"):AjaxResult.newInstance().doFail("修改失败");
    }

    @RequestMapping("list")
    @ResponseBody
    public Object list(Pager pager, HttpServletRequest request, Info info){
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectList(info);
        return PageUtil.getResult(page);
    }

    @RequestMapping("stageList")
    @ResponseBody
    public Object stageList(Pager pager){
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectStageList();
        return PageUtil.getResult(page);
    }

    @RequestMapping("stageListNoPage")
    @ResponseBody
    public Object stageListNoPage(){
        return AjaxResult.newInstance().doSuccess("ok",service.selectStageList());
    }

    @RequestMapping("updateStage")
    @ResponseBody
    public AjaxResult updateStage(Stage stage){
        return stageMapper.updateByPrimaryKey(stage)>0? AjaxResult.newInstance().doSuccess("修改成功"):AjaxResult.newInstance().doFail("修改失败");
    }

    @RequestMapping("stageDetail")
    @ResponseBody
    public AjaxResult stageDetail(Integer id){
        return  AjaxResult.newInstance().doSuccess("修改成功",stageMapper.selectByPrimaryKey(id));
    }
}
