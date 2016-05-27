package com.crossd.dao.impl;

/**
 * Created by wise.wu on 15-8-28.
 */

import com.crossd.domain.Admin;
import com.crossd.domain.AdminPrivilege;
import com.crossd.dao.AdminDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class AdminDaoImpl implements AdminDao {

    private static final String LIST_ALL_BY_CRITERIA = "fzb.admin.listAllByCriteria";
    private static final String COUNT_ALL_BY_CRITERIA = "fzb.admin.countAllByCriteria";

    private static final String LIST_ADMIN_PRIVILEGE = "fzb.adminPrivilege.listAdminPrivilege";
    private static final String LIST_PRIVILEGE_ADMIN = "fzb.adminPrivilege.listPrivilegeAdmin";
    private static final String ADD_BATCH_PRI = "fzb.adminPrivilege.addBatchPri";
    private static final String DELETE_PRI = "fzb.adminPrivilege.deletePri";

    private static final String CHECK_LOGIN = "fzb.admin.checkLogin";

    private static final String ADD_ADMIN = "fzb.admin.addAdmin";
    private static final String DEL_ADMIN = "fzb.admin.deleteAdmin";
    private static final String UPDATE_LOGIN_TIME = "fzb.admin.updateLoginTime";

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    @Override
    public int countAdminByCriteria(Map<String,Object> params) {
        return sqlSessionTemplate.selectOne(COUNT_ALL_BY_CRITERIA, params);
    }

    @Override
    public List<Admin> listAdminByCriteria(Map<String,Object> params) {
        return sqlSessionTemplate.selectList(LIST_ALL_BY_CRITERIA, params);
    }

    @Override
    public List<AdminPrivilege> getAdminPrivileges(String adminName) {
        return sqlSessionTemplate.selectList(LIST_ADMIN_PRIVILEGE,adminName);
    }

    @Override
    public List<AdminPrivilege> getPrivilegeAdmin(String adminName) {
        return sqlSessionTemplate.selectList(LIST_PRIVILEGE_ADMIN,adminName);
    }

    @Override
    public boolean addBatchPri(List<AdminPrivilege> list) {
        return (sqlSessionTemplate.insert(ADD_BATCH_PRI, list) == list.size());
    }

    @Override
    public boolean deletePri(String adminName) {
        return sqlSessionTemplate.delete(DELETE_PRI, adminName)>=0;
    }

    @Override
    public Admin checkLogin(String adminName, String adminPassword) {
        Map<String, String> param = new HashMap<String, String>();
        param.put("adminName", adminName);
        param.put("adminPassword", adminPassword);
        return sqlSessionTemplate.selectOne(CHECK_LOGIN, param);
    }

    @Override
    public boolean addAdmin(Admin admin) {
        return sqlSessionTemplate.insert(ADD_ADMIN, admin)>0;
    }

    @Override
    public boolean delAdmin(String adminName){
        return sqlSessionTemplate.delete(DEL_ADMIN, adminName)>0;
    }

    @Override
    public boolean updateLoginTime(String adminName, Date date) {
        Map<String, Object> param = new HashMap<String,Object>();
        param.put("adminName", adminName);
        param.put("lastLoginTime", date);
        return ( sqlSessionTemplate.update(UPDATE_LOGIN_TIME, param) ==1);
    }

}
