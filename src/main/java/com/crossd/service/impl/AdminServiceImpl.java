package com.crossd.service.impl;

/**
 * Created by wise.wu on 15-8-28.
 */

import com.crossd.domain.Admin;
import com.crossd.domain.AdminPrivilege;
import com.crossd.dao.AdminDao;
import com.crossd.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDao adminDao;

    @Override
    public int countAdminByCriteria(Map<String, Object> paramMap) {
        return adminDao.countAdminByCriteria(paramMap);
    }

    @Override
    public List<Admin> listAdminByCriteria(Map<String, Object> paramMap) {
        return adminDao.listAdminByCriteria(paramMap);
    }

    @Override
    public List<AdminPrivilege> listAdminPrivileges(String adminName) {
        return adminDao.getAdminPrivileges(adminName);
    }

    @Override
    public List<AdminPrivilege> listPrivilegesAdmin(String adminName) {
        return adminDao.getPrivilegeAdmin(adminName);
    }

    @Override
    @Transactional
    public boolean updatePri(String adminName, String priData) {
        List<AdminPrivilege> list = new ArrayList<AdminPrivilege>();
        String[] pris = priData.split(";");
        for (int i = 0; i < pris.length; i++) {
            String[] priDetail = pris[i].split("_");
            if (priDetail!=null && priDetail.length == 3) {
                AdminPrivilege adminPrivilege = new AdminPrivilege();
                boolean readable = "1".equals(priDetail[1]);
                boolean writable = "1".equals(priDetail[2]);

                adminPrivilege.setReadable(readable);
                adminPrivilege.setWritable(writable);
                adminPrivilege.setAdminName(adminName);
                adminPrivilege.setPrivilegeId(Integer.parseInt(priDetail[0]));
                Date d = new Date();
                adminPrivilege.setCreateTime(d);
                adminPrivilege.setUpdateTime(d);
                list.add(adminPrivilege);
            }
        }
        if (list.size()>0) {
            boolean deleteSuccess = adminDao.deletePri(adminName);
            boolean addSuccess = adminDao.addBatchPri(list);
            return (addSuccess&&deleteSuccess);
        }
        return false;
    }

    @Override
    @Transactional
    public Admin login(String adminName, String password) {
        Admin admin = adminDao.checkLogin(adminName, password);
        if (admin != null) {
            //todo 更新登陆时间
            updateLoginTime(adminName, new Date());
            //获取权限列表
            List<AdminPrivilege> list = adminDao.getAdminPrivileges(adminName);
            Map<String, AdminPrivilege> map = new HashMap<String, AdminPrivilege>();
            for(AdminPrivilege pri : list){
                map.put(pri.getUrlPath(), pri);
            }
            admin.setPrivlegeMap(map);
            return admin;
        }
        return null;
    }

    @Override
    public boolean saveAdmin(String adminName, String adminRealName,
                             String adminPassword, boolean superAdmin) {
        Admin admin = new Admin();
        admin.setAdminName(adminName);
        admin.setAdminRealName(adminRealName);
        admin.setAdminPassword(adminPassword);
        admin.setCreateTime(new Date());
        //admin.setLastLoginTime(new Date());
        admin.setSuperAdmin(superAdmin);
        return adminDao.addAdmin(admin);
    }

    @Override
    @Transactional
    public boolean delAdmin(String adminName){
        boolean delPriResult = adminDao.deletePri(adminName);
        return(delPriResult && adminDao.delAdmin(adminName));
    }

    @Override
    public boolean updateLoginTime(String adminName, Date date) {
        return adminDao.updateLoginTime(adminName, date);
    }

}
