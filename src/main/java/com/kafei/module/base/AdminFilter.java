package com.kafei.module.base;

import org.springframework.web.util.WebUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


public class AdminFilter implements javax.servlet.Filter{
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String url = ((HttpServletRequest) request).getRequestURI();
        Object userSession = WebUtils.getSessionAttribute(((HttpServletRequest) request), "managerSession");
        if(userSession==null && url.indexOf("loginAdmin.action")==-1){
            ((HttpServletResponse)response).sendRedirect("login.jsp");
        }else{
            chain.doFilter(request,response);
        }
    }

    @Override
    public void destroy() {
    }
}
