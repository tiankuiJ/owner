package com.kafei.module.ad;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.module.ad.service.AdService;
import com.kafei.util.AjaxResult;
import com.kafei.util.DateUtils;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.vo.Ad;
import com.kafei.vo.Manager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("ad")
public class AdController {
    @Autowired
    private AdService service;

    @RequestMapping("listUI")
    public String listUI(){
        return "ad/list";
    }

    @RequestMapping("formUI")
    public String formUI(Integer id, Model model){
        if(id!=null){
            Ad ad = service.selectByPrimaryKey(id);
            model.addAttribute("m",ad);
            model.addAttribute("startTime", DateUtils.forMatDateWithNoTime(ad.getStartTime()));
            model.addAttribute("endTime", DateUtils.forMatDateWithNoTime(ad.getEndTime()));
        }
        return "ad/form";
    }

    @RequestMapping("list")
    @ResponseBody
    public Object list(HttpServletRequest request, Ad activity, Pager pager){
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if(manager.getOrgType()!=null){
            if(manager.getOrgType().equals("社区")){
                activity.setChildOrg(manager.getChildOrg());
                activity.setOrgId(manager.getOrgId());
            }
            if(manager.getOrgType().equals("小区"))
                activity.setOrgId(manager.getOrgId());
        }
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectList(activity);
        return PageUtil.getResult(page);
    }

    @RequestMapping("del")
    @ResponseBody
    public AjaxResult del(Integer id){
        return service.deleteByPrimaryKey(id)>0?AjaxResult.newInstance().doSuccess("删除成功"):AjaxResult.newInstance().doFail("删除失败");
    }

    @RequestMapping("add")
    @ResponseBody
    public AjaxResult add(Ad activity, HttpServletRequest request){
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");
        if(manager.getOrgType()==null || !manager.getOrgType().equals("社区"))
            return AjaxResult.newInstance().doFail("轮播图只能由社区管理员添加");
        activity.setOrgId(manager.getOrgId());
        return service.insertSelective(activity)>0?AjaxResult.newInstance().doSuccess("添加成功"):AjaxResult.newInstance().doFail("添加失败");
    }
    @RequestMapping("update")
    @ResponseBody
    public AjaxResult update(Ad activity,HttpServletRequest request){
        return service.updateByPrimaryKeySelective(activity)>0?AjaxResult.newInstance().doSuccess("修改成功"):AjaxResult.newInstance().doFail("修改失败");
    }

}
