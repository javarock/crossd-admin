package com.crossd.controller;

/**
 * Created by wise.wu on 15-8-28.
 */

import com.crossd.bean.Success;
import com.crossd.domain.AdminPrivilege;
import com.crossd.service.AdminService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/adminPriv")
public class AdminPrivController extends BaseController {

    @Autowired
    private AdminService service;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() throws Exception {
        return "user/adminPrivList";
    }

    @ResponseBody
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public Success save() {
        return null;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Success delete() throws Exception {
        return null;
    }



    @RequestMapping(value = { "/priAdminData" }, method = RequestMethod.GET)
    public void priAdminData(String adminName) throws Exception {
        List<AdminPrivilege> adminPrivileges = service.listPrivilegesAdmin(adminName);
        JSONObject result = new JSONObject();
        int total = adminPrivileges.size();
        result.put("page", 1);
        result.put("total", total);
        // 总记录数
        result.put("records", total);
        result.put("rows", JSONArray.fromObject(adminPrivileges));
        response.getWriter().print(result.toString());
    }
    @RequestMapping(value = { "/savePriData" }, method = RequestMethod.POST)
    public void savePriData(String priData,String adminName) throws Exception {
        //System.out.println(priData+" "+adminName);
        boolean result = false;
        if(!StringUtils.isEmpty(priData)&&!StringUtils.isEmpty(adminName))
            result = service.updatePri(adminName, priData);
        response.getWriter().print(result);
    }
}
