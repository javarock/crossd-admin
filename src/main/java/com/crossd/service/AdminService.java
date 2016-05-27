package com.crossd.service;

/**
 * Created by wise.wu on 15-8-28.
 */


import com.crossd.domain.Admin;
import com.crossd.domain.AdminPrivilege;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface AdminService {

    int countAdminByCriteria(Map<String, Object> paramMap);

    List<Admin> listAdminByCriteria(Map<String, Object> paramMap);

    /**
     * admin 拥有的所有权限
     * @param adminName
     * @return
     */
    List<AdminPrivilege> listAdminPrivileges(String adminName);

    /**
     * 返回权限列表包括admin未拥有的
     * @param adminName
     * @return
     */
    List<AdminPrivilege> listPrivilegesAdmin(String adminName);

    /**
     * 更新admin权限数据，priData格式为 priId_read_write;
     * @param adminName
     * @param priData
     * @return
     */
    boolean updatePri(String adminName, String priData);

    Admin login(String adminName, String password);

    boolean saveAdmin(String adminName, String adminRealName, String adminPassword, boolean superAdmin);

    boolean delAdmin(String adminName);

    boolean updateLoginTime(String adminName, Date date);

}
