package com.example.spidercommunity.common.base;


import com.example.spidercommunity.common.*;

import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebFilter("/*")
public class SecurityFilter implements Filter {

    @Resource
    private CommonService commonService;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Headers", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST");
        response.setHeader("Allow", "POST");

        String path = request.getServletPath();
        System.out.println(path);

        if("/".equals(path.substring(0,1))){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        if("/user/login".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        if("/user/login/checkPhone".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        if("/user/login/getUid".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        if("/user/register".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }

        if("/user/register/check".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }
//
//        if("/user/tab/hot".equals(path)){
//            filterChain.doFilter(servletRequest,servletResponse);
//            return;
//        }
//
//        if("/user/tab/recommend".equals(path)){
//            filterChain.doFilter(servletRequest,servletResponse);
//            return;
//        }
//
//        if("/user/search".equals(path)){
//            filterChain.doFilter(servletRequest,servletResponse);
//            return;
//        }

        if("/admin/login".equals(path)){
            filterChain.doFilter(servletRequest,servletResponse);
            return;
        }
//        if("/admin".equals(path.substring(0, 6))){
//            filterChain.doFilter(servletRequest,servletResponse);
//            return;
//        }
//        if("/".equals(path.substring(0, 1))){
//            filterChain.doFilter(servletRequest,servletResponse);
//            return;
//        }


        String clientToken = request.getHeader(Constants.HEADER_TOKEN);
        System.out.println(".....");
        System.out.println(clientToken);

        try {
            TokenUtils.verifyToken(clientToken, commonService);
        } catch (Exception e) {
            e.printStackTrace();
            Utils.outJson(response, Result.fail(Result.ERR_CODE_UNLOGIN,e.getMessage()));
            return;
        }

        try {
            filterChain.doFilter(servletRequest,servletResponse);
        } catch (Exception e) {
            e.printStackTrace();
            Utils.outJson(response, Result.fail(Result.ERR_CODE_SYS,e.getMessage()));
        }
    }

    @Override
    public void destroy() {
    }
}
