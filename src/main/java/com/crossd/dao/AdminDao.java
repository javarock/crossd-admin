package com.crossd.dao;

/**
 * Created by wise.wu on 15-8-28.
 */

import com.crossd.domain.Admin;
import com.crossd.domain.AdminPrivilege;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface AdminDao {

    int countAdminByCriteria(Map<String, Object> params);

    List<Admin> listAdminByCriteria(Map<String, Object> params);

    List<AdminPrivilege> getAdminPrivileges(String adminName);

    /**
     * 获取权限列表包括admin未拥有的
     * @param adminName
     * @return
     */
    List<AdminPrivilege> getPrivilegeAdmin(String adminName);

    /**
     * 批量添加权限
     * @param list
     * @return
     */
    boolean addBatchPri(List<AdminPrivilege> list);

    boolean deletePri(String adminName);

    Admin checkLogin(String adminName, String adminPassword);

    boolean addAdmin(Admin admin);

    boolean delAdmin(String adminName);

    boolean updateLoginTime(String adminName, Date date);


}
