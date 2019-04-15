package com.kafei.module.org;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.module.org.service.OrgService;
import com.kafei.util.AjaxResult;
import com.kafei.util.PageUtil;
import com.kafei.util.Pager;
import com.kafei.util.SessionUtil;
import com.kafei.vo.Manager;
import com.kafei.vo.Org;
import org.apache.xmlbeans.impl.xb.xsdschema.Public;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("adminOrg")
public class OrgController {
    @Autowired
    private OrgService service;

    @RequestMapping("sheQuListUI")
    public String shequUI(){
        return "org/sheQuList";
    }

    @RequestMapping("xiaoQuListUI")
    public String xiaoQuListUI(){
        return "org/xiaoQuList";
    }

    /**
     * 社区列表
     * @param org
     * @param request
     * @param pager
     * @return
     */
    @RequestMapping("sheQuList")
    @ResponseBody
    public Object sheQuList(Org org, HttpServletRequest request, Pager pager){
        Manager manager = SessionUtil.getManagerSession(request);
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        if(manager.getOrgType()!=null && manager.getOrgType().equals("社区")){
            org.setId(manager.getOrgId());
        }
        service.selectSheQu(org);
        return PageUtil.getResult(page);
    }

    @RequestMapping("sheQuListNoPage")
    @ResponseBody
    public Object sheQuListNoPage(Org org, HttpServletRequest request, Pager pager){
        return AjaxResult.newInstance().doSuccess("查询成功",service.selectSheQu(org));
    }

    /**
     * 小区列表
     * @param org
     * @param request
     * @param pager
     * @return
     */
    @RequestMapping("xiaoQuList")
    @ResponseBody
    public Object xiaoQuList(Org org, HttpServletRequest request, Pager pager){
        Manager manager = SessionUtil.getManagerSession(request);
        if(manager.getOrgType()!=null && manager.getOrgType().equals("社区")){
            org.setpId(manager.getOrgId());
        }else if(manager.getOrgType()!=null && manager.getOrgType().equals("小区")){
            org.setpId(null);
            org.setId(manager.getOrgId());
        }
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(),pager.getSidx()+" "+pager.getSord());
        service.selectXiaoQu(org);
        return PageUtil.getResult(page);
    }

    @RequestMapping("xiaoQuListNoPage")
    @ResponseBody
    public Object xiaoQuListNoPage(Org org, HttpServletRequest request){
        Manager manager = SessionUtil.getManagerSession(request);
        if(manager!=null){
            if(manager.getOrgType()!=null && manager.getOrgType().equals("社区")){
                org.setpId(manager.getOrgId());
            }else if(manager.getOrgType()!=null && manager.getOrgType().equals("小区")){
                org.setpId(null);
                org.setId(manager.getOrgId());
            }
        }
        return service.selectXiaoQu(org);
    }


    @RequestMapping("xiaoQuListData")
    @ResponseBody
    public AjaxResult xiaoQuListData(Org org, HttpServletRequest request){
        return AjaxResult.newInstance().doSuccess("success",service.selectXiaoQu(org));
    }

    @RequestMapping("addOrg")
    @ResponseBody
    public AjaxResult addOrg(Org org,HttpServletRequest request){
        System.out.println(JSON.toJSONString(org));
        return service.insertSelective(org)>0?AjaxResult.newInstance().doSuccess("添加成功"):AjaxResult.newInstance().doFail("添加失败");
    }

    @RequestMapping("update")
    @ResponseBody
    public AjaxResult update(Org org,HttpServletRequest request){
        return service.updateByPrimaryKeySelective(org)>0?AjaxResult.newInstance().doSuccess("修改成功"):AjaxResult.newInstance().doFail("修改失败");
    }

    @RequestMapping("detail")
    @ResponseBody
    public AjaxResult detail(Integer id){
        return AjaxResult.newInstance().doSuccess("ok",service.selectByPrimaryKey(id));
    }

    @RequestMapping(value = "falseDelete", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult falseDelete(Integer id) {
        return service.falseDelete(id) > 0 ? AjaxResult.newInstance().doSuccess("删除成功") : AjaxResult.newInstance().doFail("删除失败");
    }


}
