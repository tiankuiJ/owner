package com.kafei.module.opInfo;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.module.opInfo.service.OpInfoService;
import com.kafei.util.AjaxResult;
import com.kafei.util.DateUtils;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.vo.Manager;
import com.kafei.vo.OpInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("opInfo")
public class OpInfoController {
    @Autowired
    private OpInfoService service;

    @RequestMapping("listUI")
    public String listUI(String type){
        if(type!=null){
            return "opInfo/"+type;
        }
        return null;
    }

    @RequestMapping("formUI")
    public String formUI(Integer id, Model model){
        if(id!=null){
            OpInfo info = service.selectByPrimaryKey(id);
            model.addAttribute("m",info);
            model.addAttribute("startTime", DateUtils.forMatDateWithNoTime(info.getStartTime()));
            model.addAttribute("endTime", DateUtils.forMatDateWithNoTime(info.getEndTime()));
        }
        return "opInfo/form";
    }

    @RequestMapping("list")
    @ResponseBody
    public Object list(OpInfo info, HttpServletRequest request, Pager pager){
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if(manager.getOrgType()!=null){
            if(manager.getOrgType().equals("社区")){
                info.setChildOrg(manager.getChildOrg());
                info.setOrgId(manager.getOrgId());
            }
            if(manager.getOrgType().equals("小区"))
                info.setOrgId(manager.getOrgId());
        }
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectList(info);
        return PageUtil.getResult(page);
    }


    @RequestMapping("add")
    @ResponseBody
    public AjaxResult add(OpInfo activity, HttpServletRequest request) throws Exception {
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if(manager.getOrgType()==null)
            return AjaxResult.newInstance().doFail("只能由社区管理员和小区管理员添加");
        activity.setOrgId(manager.getOrgId());
        return service.insertSelective(activity,manager.getOrgId(),request)>0?AjaxResult.newInstance().doSuccess("添加成功"):AjaxResult.newInstance().doFail("添加失败");
    }

    @RequestMapping("update")
    @ResponseBody
    public AjaxResult update(OpInfo activity,HttpServletRequest request){
        return service.updateByPrimaryKeySelective(activity)>0?AjaxResult.newInstance().doSuccess("修改成功"):AjaxResult.newInstance().doFail("修改失败");
    }

    @RequestMapping("del")
    @ResponseBody
    public AjaxResult del(Integer id){
        return service.deleteByPrimaryKey(id)>0?AjaxResult.newInstance().doSuccess("删除成功"):AjaxResult.newInstance().doFail("删除失败");
    }

    @RequestMapping("selectByIds")
    @ResponseBody
    public Object selectByIds(String ids){
        return service.selectByIds(ids);
    }



}
