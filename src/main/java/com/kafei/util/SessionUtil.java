package com.kafei.util;

import com.kafei.vo.Manager;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;

public class SessionUtil {


    public static Manager getManagerSession(HttpServletRequest request){
        return (Manager) WebUtils.getSessionAttribute(request,"managerSession");
    }
}
