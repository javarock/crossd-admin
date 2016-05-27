package com.crossd.domain;


import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.Map;

@Alias("Admin")
public class Admin {
    private String adminName;
    private String adminPassword;
    private String adminRealName;
    private Date createTime;
    private Date lastLoginTime;
    private boolean isSuperAdmin;

    private Map<String, AdminPrivilege> privlegeMap;

    public String getAdminName() {
        return adminName;
    }
    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }
    public String getAdminPassword() {
        return adminPassword;
    }
    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }
    public String getAdminRealName() {
        return adminRealName;
    }
    public void setAdminRealName(String adminRealName) {
        this.adminRealName = adminRealName;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getLastLoginTime() {
        return lastLoginTime;
    }
    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }
    public boolean isSuperAdmin() {
        return isSuperAdmin;
    }
    public void setSuperAdmin(boolean isSuperAdmin) {
        this.isSuperAdmin = isSuperAdmin;
    }
    public boolean getIsSuperAdmin(){
        return isSuperAdmin;
    }
    public void setIsSuperAdmin(boolean isSuperAdmin){
        this.isSuperAdmin = isSuperAdmin;
    }
    public Map<String, AdminPrivilege> getPrivlegeMap() {
        return privlegeMap;
    }
    public void setPrivlegeMap(Map<String, AdminPrivilege> privlegeMap) {
        this.privlegeMap = privlegeMap;
    }
}
