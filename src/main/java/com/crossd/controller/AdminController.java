package com.crossd.controller;

/**
 * Created by wise.wu on 15-8-28.
 */


import com.crossd.bean.Constant;
import com.crossd.domain.Admin;
import com.crossd.service.AdminService;
import com.crossd.tools.AESUtil;
import com.crossd.tools.JsonTimeFormatConfig;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@Scope("prototype")
@RequestMapping("/admin")
public class AdminController extends BaseController{

    @Autowired
    private AdminService adminService;

    @RequestMapping("/list")
    public String list() throws Exception {
        return "adminList";
    }

    @RequestMapping(value = { "/data" }, method = RequestMethod.GET)
    public void data(String adminName, String adminRealName,String createTimeFrom,
                     String createTimeTo,String lastTimeLoginFrom,String LastTimeLoginTo,
                     Integer page, Integer rows) throws Exception {

        Map<String,Object> paramMap = buildParamMap(adminName, adminRealName,createTimeFrom,
                createTimeTo,lastTimeLoginFrom,LastTimeLoginTo);

        int totalNum = adminService.countAdminByCriteria(paramMap);
        int totalPage = totalNum%rows == 0 ? totalNum/rows : totalNum/rows +1;
        int from = (page-1) * rows;
        int number = totalNum - page*rows > 0 ? rows : totalNum - (page-1)*rows;

        paramMap.put("from", from);
        paramMap.put("number", number);

        List<Admin> admins = adminService.listAdminByCriteria(paramMap);

        JSONObject result = new JSONObject();
        result.put("page", page);
        result.put("total", totalPage);
        result.put("records", totalNum);
        result.put("rows", JSONArray.fromObject(admins, JsonTimeFormatConfig.getJsonConfig()));

        response.getWriter().print(result.toString());
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public void delete(String adminName) throws Exception {
        JSONObject result = new JSONObject();
        try {
            boolean success = adminService.delAdmin(adminName);
            result.put("success", success);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        response.getWriter().print(result.toString());
    }

    @RequestMapping(value = { "/save" }, method = RequestMethod.POST)
    public void save(final String adminName,final String adminRealName, final String adminPassword, Integer superAdmin)
            throws Exception {
        final boolean isSuperAdmin;
        if (superAdmin!=null&&superAdmin.intValue()==1) {
            isSuperAdmin = true;
        }else{
            isSuperAdmin = false;
        }

        JSONObject result = new JSONObject();
        if (StringUtils.isBlank(adminName)|| StringUtils.isBlank(adminPassword)) {
            result.put("success", false);
            return;
        }

        String encryptPassword = AESUtil.encryptToString(adminPassword, Constant.ENCRYPT_KEY);

        try {
            adminService.saveAdmin(adminName, adminRealName, encryptPassword, isSuperAdmin);
            result.put("success", true);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
        }
        response.getWriter().print(result.toString());
    }


    public Map<String,Object> buildParamMap(String adminName, String adminRealName,String createTimeFrom,
                                            String createTimeTo,String lastTimeLoginFrom,String LastTimeLoginTo){
        Map<String, Object> result = new HashMap<String,Object>();
        if (!StringUtils.isBlank(adminName)) {
            result.put("adminName", adminName);
        }
        if (!StringUtils.isBlank(adminRealName)) {
            result.put("adminRealName", adminRealName);
        }
        if (!StringUtils.isBlank(createTimeFrom)) {
            result.put("createTimeFrom", createTimeFrom);
        }
        if (!StringUtils.isBlank(createTimeTo)) {
            result.put("createTimeTo", createTimeTo);
        }
        if (!StringUtils.isBlank(lastTimeLoginFrom)) {
            result.put("lastTimeLoginFrom", lastTimeLoginFrom);
        }
        if (!StringUtils.isBlank(LastTimeLoginTo)) {
            result.put("LastTimeLoginTo", LastTimeLoginTo);
        }
        return result;
    }

}