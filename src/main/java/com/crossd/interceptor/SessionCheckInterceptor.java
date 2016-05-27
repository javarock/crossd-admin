package com.crossd.interceptor;

/**
 * Created by wise.wu on 15-8-28.
 */

import com.crossd.bean.Constant;
import com.crossd.domain.Admin;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.Map;

public class SessionCheckInterceptor implements HandlerInterceptor{

    @Override
    // TODO 针对ajax请求和后台的请求type限定优化
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {

        //todo
        //return true;

        // XMLHttpRequest 这个方法兼容所有的浏览器吗？？
        // 此次请求是否是ajax请求
        boolean isAjax = "XMLHttpRequest".equals(request
                .getHeader("X-Requested-With"));
        HttpSession session = request.getSession();

        Admin admin = (Admin)session.getAttribute(Constant.admin_session_key);
        if (isAjax) {
            if (admin == null) {
                response.setHeader("sessionout", "true");
                return false;
            }
        } else {
            if (admin == null) {
                // 未登录
                session.removeAttribute(Constant.return_url_session_key);
                // TODO 感觉这个returnUrl有问题？？？？
                // returnUrl一定代表的是get请求，后台有get和post的限定，在返回url的时候可能会出现异常
                session.setAttribute(Constant.return_url_session_key,
                        URLEncoder.encode(this.buildRequestURL(request),
                                "UTF-8"));
                // 跳转到登录页面
                response.sendRedirect(request.getContextPath() + "/toLogin");
                return false;
            }

        }
        return true;
    }



    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    }

    /**
     * 构造待返回的url，主要是将其所带的参数拼装好
     *
     * @param request
     * @return
     */
    @SuppressWarnings("unchecked")
    private String buildRequestURL(HttpServletRequest request) {
        Map<String, String[]> paramMap = request.getParameterMap();
        // 上下文路径
        String path = request.getContextPath();
        String url = request.getRequestURI();
        // 去掉上下文路径
        url = url.substring(path.length(), url.length());
        StringBuilder URL = new StringBuilder(url + "?");
        for (Map.Entry<String, String[]> entry : paramMap.entrySet()) {
            String key = entry.getKey();
            String[] values = entry.getValue();
            if (values.length > 1) {
                for (String value : values) {
                    URL.append(key).append("=").append(value).append("&");
                }
            } else {
                URL.append(key).append("=").append(values[0]).append("&");
            }
        }
        return URL.substring(0, URL.length() - 1);
    }
}
