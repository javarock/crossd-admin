package com.crossd.interceptor;

import com.crossd.bean.Constant;
import com.crossd.domain.Admin;
import com.crossd.domain.AdminPrivilege;
import net.sf.json.JSONObject;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;


public class PrivCheckInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        //去掉了首位'/'号
        String path = request.getServletPath().substring(1);
        if (path.indexOf('/')>0) {
            path = path.substring(0,path.indexOf('/'));
        }
        String requestMethod = request.getMethod();

        HttpSession session = request.getSession();
        Admin admin = (Admin)session.getAttribute(Constant.admin_session_key);

        if (admin == null) {
            JSONObject json = new JSONObject();
            json.put("result", "please login");
            response.getWriter().print(json.toString());
            return false;
        }
        if (admin.isSuperAdmin()) {
            return true;
        }
        boolean hasPri = false;
        if (admin.getPrivlegeMap().containsKey(path)) {
            if ("GET".equalsIgnoreCase(requestMethod)){
                hasPri = admin.getPrivlegeMap().get(path).getReadable();
            }else{
                hasPri = admin.getPrivlegeMap().get(path).getWritable();
            }
        }

        if (!hasPri) {
            JSONObject json = new JSONObject();
            json.put("result", "no privilege");
            response.getWriter().print(json.toString());
        }
        return hasPri;
    }



    boolean checkPriv(Admin admin,String contextPath){
        //普通路径

        Map<String, AdminPrivilege> map = admin.getPrivlegeMap();
        if (map.containsKey(contextPath)) {
            return true;
        }
        return false;
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

}
