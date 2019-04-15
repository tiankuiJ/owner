package com.kafei.module.activity;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.module.activity.service.ActivityService;
import com.kafei.util.AjaxResult;
import com.kafei.util.DateUtils;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.vo.Activity;
import com.kafei.vo.Manager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("activity")
public class ActivityController {
    @Autowired
    private ActivityService service;

    @RequestMapping("listUI")
    public String listUI(){
        return "activity/list";
    }

    @RequestMapping("formUI")
    public String formUI(Integer id, Model model){
        if(id!=null){
            Activity info = service.selectByPrimaryKey(id);
            model.addAttribute("m",info);
        }
        return "activity/form";

    }


    @RequestMapping("list")
    @ResponseBody
    public Object list(HttpServletRequest request, Activity activity, Pager pager, HttpServletResponse response){
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if (manager!=null){
            if(manager.getOrgType()!=null){
                if(manager.getOrgType().equals("社区")){
                    activity.setChildOrg(manager.getChildOrg());
                    activity.setOrgId(manager.getOrgId());
                }
                if(manager.getOrgType().equals("小区"))
                    activity.setOrgId(manager.getOrgId());
            }
        }
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectList(activity);
        return PageUtil.getResult(page);
    }


    @RequestMapping("add")
    @ResponseBody
    public AjaxResult add(Activity activity,HttpServletRequest request) throws Exception {
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if(manager.getOrgType()==null)
            return AjaxResult.newInstance().doFail("活动只能由社区管理员和小区管理员添加");
        activity.setOrgId(manager.getOrgId());
        return service.insertSelective(activity,manager.getOrgId(),request)>0?AjaxResult.newInstance().doSuccess("添加成功"):AjaxResult.newInstance().doFail("添加失败");
    }

    @RequestMapping("update")
    @ResponseBody
    public AjaxResult update(Activity activity,HttpServletRequest request){
        return service.updateByPrimaryKeySelective(activity)>0?AjaxResult.newInstance().doSuccess("修改成功"):AjaxResult.newInstance().doFail("修改失败");
    }

    @RequestMapping("detail")
    @ResponseBody
    public AjaxResult detail(Integer id){
        return AjaxResult.newInstance().doSuccess("查询成功",service.selectByPrimaryKey(id));
    }

    @RequestMapping("del")
    @ResponseBody
    public AjaxResult del(Integer id){
        return service.delete(id)>0?AjaxResult.newInstance().doSuccess("删除成功"):AjaxResult.newInstance().doFail("删除失败");
    }

}
