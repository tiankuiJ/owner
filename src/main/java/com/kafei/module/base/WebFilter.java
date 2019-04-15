package com.kafei.module.base;

import com.kafei.module.base.webService.WebService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class WebFilter implements javax.servlet.Filter{
    @Autowired
    private WebService service;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
//        String url = ((HttpServletRequest) request).getRequestURI();
//        Object userSession = WebUtils.getSessionAttribute(((HttpServletRequest) request), "ownerSession");
//        if(userSession==null && url.indexOf("webLogin.xhtml")==-1){
//            Owner owner = new Owner();
//            owner.setPhone(Long.parseLong(request.getParameter("phone")));
//            WebUtils.setSessionAttribute((HttpServletRequest) request,"userSession",service.loginById(owner,(HttpServletRequest) request));
//        }else{
        ((HttpServletResponse)response).setHeader("Access-Control-Allow-Origin","*");
            chain.doFilter(request,response);
//        }
    }

    @Override
    public void destroy() {

    }
}
