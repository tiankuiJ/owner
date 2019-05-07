package com.kafei.module.manager;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.mapper.OrgMapper;
import com.kafei.mapper.OwnerMapper;
import com.kafei.module.manager.service.ManagerService;
import com.kafei.util.*;
import com.kafei.vo.Manager;
import com.kafei.vo.Org;
import com.kafei.vo.Owner;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

@Controller
public class ManagerController {

    @Autowired
    private ManagerService service;
    @Autowired
    private OrgMapper orgMapper;
    @Autowired
    private OwnerMapper ownerMapper;
    

    @RequestMapping("managerListUI")
    public String managerListUI(Integer orgId) {
        return "org/managerList";
    }

    @RequestMapping("ownerOrgListUI")
    public String ownerOrgListUI() {
        return "org/ownerOrgList";
    }

    @RequestMapping("ownerListUI")
    public String ownerListUI() {
        return "org/ownerList";
    }

    @RequestMapping("selectList")
    @ResponseBody
    public Object selectList(Pager pager, Manager manager, HttpServletRequest request) {
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(), pager.getSidx() + " " + pager.getSord());
        service.selectList(manager);
        return PageUtil.getResult(page);
    }

    @RequestMapping("del")
    @ResponseBody
    public AjaxResult del(Integer id){
        return service.deleteByPrimaryKey(id)>0?AjaxResult.newInstance().doSuccess("删除成功"):AjaxResult.newInstance().doFail("删除失败");
    }

    @RequestMapping("selectOwnerList")
    @ResponseBody
    public Object selectOwnerList(Pager pager, Owner owner, HttpServletRequest request) {
        Manager manager = SessionUtil.getManagerSession(request);
        if(manager.getOrgType()!=null && manager.getOrgType().equals("社区")){
            owner.setChildOrg(manager.getChildOrg());
        }else if(manager.getOrgType()!=null && manager.getOrgType().equals("小区")){
            owner.setOrgId(manager.getOrgId());
        }
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(), pager.getSidx() + " " + pager.getSord());
        service.selectOwnerList(owner);
        return PageUtil.getResult(page);
    }

    /**
     * 查询业主和小区对应信息
     * @param pager
     * @param owner
     * @param request
     * @return
     */
    @RequestMapping("selectOwnerOrgList")
    @ResponseBody
    public Object selectOwnerOrgList(Pager pager, Owner owner, HttpServletRequest request) {
        Manager manager = SessionUtil.getManagerSession(request);
        if(manager.getOrgType()!=null && manager.getOrgType().equals("社区")){
            owner.setChildOrg(manager.getChildOrg());
        }else if(manager.getOrgType()!=null && manager.getOrgType().equals("小区")){
            owner.setOrgId(manager.getOrgId());
        }
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows(), pager.getSidx() + " " + pager.getSord());
        service.selectOwnerOrgList(owner);
        return PageUtil.getResult(page);
    }

    @RequestMapping("addManager")
    @ResponseBody
    public AjaxResult addManager(Manager manager) {
        int result = service.insertSelective(manager);
        if (result == -1)
            return AjaxResult.newInstance().doFail("该账户已存在");
        return result > 0 ? AjaxResult.newInstance().doSuccess("操作成功") : AjaxResult.newInstance().doFail("添加失败");
    }

    @RequestMapping("updateManager")
    @ResponseBody
    public AjaxResult updateManager(Manager manager) {
        return service.updateByPrimaryKeySelective(manager) > 0 ? AjaxResult.newInstance().doSuccess("操作成功") : AjaxResult.newInstance().doFail("修改失败");
    }

    @RequestMapping(value = "delete", method = RequestMethod.POST)
    @ResponseBody
    public AjaxResult delete(Integer id) {
        return service.deleteByPrimaryKey(id) > 0 ? AjaxResult.newInstance().doSuccess("删除成功") : AjaxResult.newInstance().doFail("删除失败");
    }

    @RequestMapping("addOwner")
    @ResponseBody
    public AjaxResult addOwner(Owner owner) {
        int result = service.insertOwner(owner);
        return result == -1 ? AjaxResult.newInstance().doFail("添加失败，该电话已存在") : result > 0 ? AjaxResult.newInstance().doSuccess("添加成功") : AjaxResult.newInstance().doFail("添加失败");
    }

    @RequestMapping("addOwnerOrg")
    @ResponseBody
    public AjaxResult addOwnerOrg(Owner owner) {
        int result = service.insertOwnerOrg(owner);
        return result > 0 ? AjaxResult.newInstance().doSuccess("添加成功") : AjaxResult.newInstance().doFail("添加失败");
    }

    @RequestMapping("updateOwner")
    @ResponseBody
    public AjaxResult updateOwner(Owner owner) {
        int result = service.updateOwner(owner);
        return result == -1 ? AjaxResult.newInstance().doFail("修改失败，该电话已存在") : result > 0 ? AjaxResult.newInstance().doSuccess("修改成功") : AjaxResult.newInstance().doFail("修改失败");
    }

    @RequestMapping("updateOwnerOrg")
    @ResponseBody
    public AjaxResult updateOwnerOrg(Owner owner) {
        int result = service.updateOwnerOrg(owner);
        return result > 0 ? AjaxResult.newInstance().doSuccess("修改成功") : AjaxResult.newInstance().doFail("修改失败");
    }
    @RequestMapping("deleteOwnerOrg")
    @ResponseBody
    public AjaxResult deleteOwnerOrg(Integer id) {
        int result = service.deleteOwnerOrg(id);
        return result > 0 ? AjaxResult.newInstance().doSuccess("删除成功") : AjaxResult.newInstance().doFail("删除失败");
    }


    @RequestMapping("loginAdmin")
    @ResponseBody
    public AjaxResult logiAdmin(Manager manager, HttpServletRequest request) {
        Manager result = service.login(manager);
        if (result == null)
            return AjaxResult.newInstance().doFail("登录失败");
        if(result.getOrgType()!=null && result.getOrgType().equals("社区")){
            Org org = new Org();
            org.setpId(result.getOrgId());
            List<Org> list = orgMapper.selectXiaoQu(org);
            result.setChildOrg(list);
        }
        WebUtils.setSessionAttribute(request, "managerSession", result);
        return AjaxResult.newInstance().doSuccess("登录成功");
    }

    @RequestMapping("logoutAdmmin")
    @ResponseBody
    public void logoutAdmin(HttpServletRequest request, HttpServletResponse response){
        WebUtils.setSessionAttribute(request,"managerSession",null);
        try {
            response.sendRedirect("login.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @RequestMapping("index")
    public String index(HttpServletRequest request) {
        return "index";
    }



    @RequestMapping("importOwner")
    @ResponseBody
    public AjaxResult importOwner(HttpServletRequest request,Integer orgId){
        DiskFileItemFactory fac = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(fac);
        try {
            List<FileItem> fileList = upload.parseRequest(request);
            Iterator<FileItem> it = fileList.iterator();
            while (it.hasNext()){
                FileItem file = it.next();
                if("orgId".equals(file.getFieldName())){
                    orgId = Integer.parseInt(file.getString());
                }
                if(!file.isFormField()){
                    String name = file.getName();
                    if(name==null || name.trim().equals("")){
                        continue;
                    }
                    if(name.lastIndexOf(".") >= 0){
                        String extName = name.substring(name.lastIndexOf("."));
                        if(!".xls".equals(extName) && !".xlsx".equals(extName)){
                            return AjaxResult.newInstance().doFail("请上传正确格式的表格文件");
                        }
                    }
                    JSONObject result = service.importOwner(file.getInputStream(), file.getName(),orgId);
                    if(result==null)
                        return AjaxResult.newInstance().doFail("导入失败");
                    if(result.get("errors").toString().length()>3){
                        return AjaxResult.newInstance().doFail("导入失败",result.get("errors"));
                    }
                    return AjaxResult.newInstance().doSuccess("导入成功");
                }
            }
            return null;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }




    @RequestMapping("changePassWord")
    @ResponseBody
    public Object changePassWord(String oldPassWord,String newPassWord,HttpServletRequest request) throws Exception{
        if(StringUtils.isBlank(oldPassWord) || StringUtils.isBlank(newPassWord)){
            return AjaxResult.newInstance().doFail("请输入6~16位数字或字母");
        }
        if(!Pattern.matches("^[a-z0-9A-Z]{6,16}$",newPassWord)){
            return AjaxResult.newInstance().doFail("请输入6~16位数字或字母");
        }
        oldPassWord = AESUtil.getInstance().encrypt(oldPassWord);
        newPassWord = AESUtil.getInstance().encrypt(newPassWord);
        Manager manager = (Manager) WebUtils.getSessionAttribute(request,"managerSession");

        Manager u = service.selectByPrimaryKey(manager.getId());
        if(!u.getPsd().equals(oldPassWord)){
            return AjaxResult.newInstance().doFail("原密码错误");
        }
        u.setPsd(newPassWord);
        if(service.updateByPrimaryKeySelective(u)>0){
            return AjaxResult.newInstance().doSuccess("修改成功");
        }
        return AjaxResult.newInstance().doFail("修改失败");
    }




    @RequestMapping("selectSumAcreage")
    @ResponseBody
    public AjaxResult selectSumAcreage(HttpServletRequest request,Integer orgId){
        return AjaxResult.newInstance().doSuccess("ok",ownerMapper.selectSumByOrgId(orgId));
    }

    @RequestMapping("selectOrgType")
    @ResponseBody
    public AjaxResult selectOrgType(HttpServletRequest request,Integer orgId){
        return AjaxResult.newInstance().doSuccess("ok",ownerMapper.selectOrgTypeById(orgId));
    }





}
