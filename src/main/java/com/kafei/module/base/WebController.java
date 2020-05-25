package com.kafei.module.base;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.kafei.mapper.OwnerMapper;
import com.kafei.module.base.webService.WebService;
import com.kafei.util.*;
import com.kafei.vo.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Pattern;

@Controller
public class WebController {
    @Autowired
    private WebService service;
    @Autowired
    OwnerMapper ownerMapper;

    @RequestMapping("webLogin")
    @ResponseBody
    public AjaxResult webLogin(Owner owner, HttpServletRequest request,String code) {
//        if (request.getSession().getAttribute("lastCode") == null) {
//            return AjaxResult.newInstance().doFail("验证码错误");
//        }
//        int tempRegCodeInt = (Integer) request.getSession().getAttribute("lastCode");
//        String tempRegCode = String.valueOf(tempRegCodeInt);
//        if (StringUtils.isEmpty(code.trim())
//                || !code.trim().equals(tempRegCode)) {
//            return AjaxResult.newInstance().doFail("验证码错误");
//        }
        Owner result = service.login(owner, request);
        if (result != null)
            return AjaxResult.newInstance().doSuccess("登录成功");
        return AjaxResult.newInstance().doFail("登录失败");
    }

    @RequestMapping("activityList")
    @ResponseBody
    public Object activityList(Pager pager, HttpServletRequest request, Activity activity) {
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows());
        activity.setStatus("已发布");
        service.activityList(activity);
        return PageUtil.getResult(page);
    }

    @RequestMapping("voteList")
    @ResponseBody
    public Object voteList(Pager pager, HttpServletRequest request, Vote activity) {
        activity.setInfoId(1);
        activity.setStartTime(new Date());
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows());
        service.voteList(activity);
        return PageUtil.getResult(page);
    }

    @RequestMapping("opList")
    @ResponseBody
    public Object opList(Pager pager, HttpServletRequest request, OpInfo activity) {
        activity.setInfoId(0);
        activity.setStartTime(new Date());
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows());
        service.opInfoList(activity);
        return PageUtil.getResult(page);
    }

    @RequestMapping("adList")
    @ResponseBody
    public Object adList(Pager pager, HttpServletRequest request, Ad ad) {
        Page<Object> page = PageHelper.startPage(pager.getPage(), pager.getRows());
        service.adList(ad);
        return PageUtil.getResult(page);
    }

    @RequestMapping("infoList")
    @ResponseBody
    public AjaxResult infoList(Info info) {
        return AjaxResult.newInstance().doSuccess("查询成功", service.infoList(info));
    }


    @RequestMapping("opInfoList")
    @ResponseBody
    public AjaxResult opInfoList(Info info) {
        return AjaxResult.newInstance().doSuccess("查询成功", service.opInfoList(info));
    }

    /**
     * 根据信息查询表决列表
     * @param infoId
     * @return
     */
    @RequestMapping("biaoJueList")
    @ResponseBody
    public AjaxResult biaoJueList(Integer infoId) {
        return AjaxResult.newInstance().doSuccess("查询成功", service.biaoJueList(infoId));
    }


    @RequestMapping("biaojueDetails")
    @ResponseBody
    public Object biaojueDetails(Integer infoId){
        return AjaxResult.newInstance().doSuccess("查询成功",service.biaojueDetails(infoId));
    }




    @RequestMapping("infoDetail")
    @ResponseBody
    public AjaxResult infoDetail(Integer id) {
        return AjaxResult.newInstance().doSuccess("查询成功", service.infoDetail(id));
    }

    @RequestMapping("regInfo")
    @ResponseBody
    public AjaxResult regInfo(RegRecord regRecord, HttpServletRequest request, String phone) {
        if (StringUtils.isBlank(phone))
            return AjaxResult.newInstance().doFail("请登录");
        Integer userId = ownerMapper.selectByPhone(phone);
        if(userId==null)
            return AjaxResult.newInstance().doFail("请登录");
        regRecord.setUserId(String.valueOf(userId));
        int result = service.regInfo(regRecord);
        if(result==-2)
            return AjaxResult.newInstance().doFail("你不属于本社区或小区");
        return result == -1 ? AjaxResult.newInstance().doFail("你已经参加过该活动") : result > 0 ? AjaxResult.newInstance().doSuccess("提交成功") : AjaxResult.newInstance().doFail("提交失败");
    }


    @RequestMapping("batchRegBiaoJue")
    @ResponseBody
    public AjaxResult batchRegBiaoJue(String recordStr, HttpServletRequest request, String phone){
        if (StringUtils.isBlank(phone))
            return AjaxResult.newInstance().doFail("请登录");
        Integer userId = ownerMapper.selectByPhone(phone);
        if(userId==null)
            return AjaxResult.newInstance().doFail("请登录");
        ArrayList<RegRecord> records = JSON.parseObject(recordStr, new TypeReference<ArrayList<RegRecord>>() {
        });
        int result = service.batchRegBiaoJue(records,userId);
        if(result==-2)
            return AjaxResult.newInstance().doFail("你不属于本社区或小区");
        return result == -1 ? AjaxResult.newInstance().doFail("你已经参加过该活动") : result > 0 ? AjaxResult.newInstance().doSuccess("提交成功") : AjaxResult.newInstance().doFail("提交失败");
    }





    @RequestMapping("regVote")
    @ResponseBody
    public AjaxResult regVote(String recordStr, HttpServletRequest request, String phone) {
        if (StringUtils.isBlank(phone))
            return AjaxResult.newInstance().doFail("请登录");
        Integer userId = ownerMapper.selectByPhone(phone);
        if(userId==null)
            return AjaxResult.newInstance().doFail("请登录");
        ArrayList<VoteRecord> records = JSON.parseObject(recordStr, new TypeReference<ArrayList<VoteRecord>>() {
        });
        int result = service.regVote(records, String.valueOf(userId));
        if(result==-2)
            return AjaxResult.newInstance().doFail("你不属于本社区或小区");
        return result == -1 ? AjaxResult.newInstance().doFail("你已经参加过该投票") : result > 0 ? AjaxResult.newInstance().doSuccess("提交成功") : AjaxResult.newInstance().doFail("提交失败");
    }

    @RequestMapping("voteInfo")
    @ResponseBody
    public AjaxResult voteInfo(Integer id) {
        return AjaxResult.newInstance().doSuccess("查询成功", service.voteInfo(id));
    }

    @RequestMapping("opInfoDetail")
    @ResponseBody
    public AjaxResult opInfoDetail(Integer id) {
        return AjaxResult.newInstance().doSuccess("查询成功", service.opInfoDetail(id));
    }

    @RequestMapping("regCode")
    @ResponseBody
    public AjaxResult regCode(HttpServletRequest request, String phone) {
        if (request.getSession().getAttribute("lastCodeTime") != null) {
            Date date = (Date) request.getSession().getAttribute("lastCodeTime");
            if (DateUtils.miBetween(date, new Date()) < 1) {
                return AjaxResult.newInstance().doFail("一分钟内重复发送");
            }
        }
        int code = (int) ((Math.random() * 9 + 1) * 100000);
        String content = "您的验证码是" + code + "，在30分钟内有效。如非本人操作请忽略本短信。【社区活动】";
        String result = SMSService.sendCode(phone.trim(), content, null);
        request.getSession().setAttribute("lastCode", code);//code
        request.getSession().setAttribute("lastCodeTime", new Date());
        return AjaxResult.newInstance().doSuccess(result);//result
    }
}
