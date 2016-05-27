package com.crossd.controller;

/**
 * Created by wise.wu on 15-8-28.
 */

import com.crossd.bean.Constant;
import com.crossd.domain.Admin;
import com.crossd.service.AdminService;
import com.crossd.tools.AESUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;
import java.net.URLDecoder;

@Controller
public class IndexController extends BaseController {

    @Autowired
    private AdminService adminService;
    /**
     * 首页
     *
     * @return
     */
    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/iframe")
    public String iframe() {
        return "iframe";
    }

    /**
     * 跳转到登陆页面
     *
     * @return
     */
    @RequestMapping("/toLogin")
    public String toLogin() {
        return "login";
    }

    @RequestMapping("/loginout")
    public String loginout() {
        session.removeAttribute(Constant.login_error_session_key);
        session.removeAttribute(Constant.admin_session_key);
        return "redirect:toLogin";
    }

    @RequestMapping("/login")
    public String login(String fdName, String fdPassword) throws IOException {
        session.removeAttribute(Constant.login_error_session_key);
        if (StringUtils.isBlank(fdName) || StringUtils.isBlank(fdPassword)) {
            session.setAttribute(Constant.login_error_session_key,
                    "用户名或密码不能为空");
            // 跳到到登录页面
            return "redirect:toLogin";
        }
        String encryptPassword = AESUtil.encryptToString(fdPassword, Constant.ENCRYPT_KEY);
        Admin admin = adminService.login(fdName, encryptPassword);


        if (admin!=null) {
            String returnUrl = (String) session
                    .getAttribute(Constant.return_url_session_key);
            if (StringUtils.isBlank(returnUrl)) {
                returnUrl = "index";
            } else {
                returnUrl = URLDecoder.decode(returnUrl, "UTF-8");
            }
            // 用户存在，且密码正确

            session.removeAttribute(Constant.login_error_session_key);
            session.setAttribute(Constant.admin_session_key,
                    admin);
            return "redirect:" + returnUrl;
        } else {
            session.setAttribute(Constant.login_error_session_key,
                    "用户名或密码错误");
            // 跳到到登录页面
            return "redirect:toLogin";

        }
    }

}
