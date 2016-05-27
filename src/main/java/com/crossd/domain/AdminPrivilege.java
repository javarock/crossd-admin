package com.crossd.domain;


import org.apache.ibatis.type.Alias;

import java.util.Date;

@Alias("AdminPrivilege")
public class AdminPrivilege {
    private int adminPriId;
    private String adminName;
    private int privilegeId;
    private Date createTime;
    private Date updateTime;
    private Boolean readable;
    private Boolean writable;

    //权限表中的字段
    private String priName;
    private String description;
    private String urlPath;



    public int getAdminPriId() {
        return adminPriId;
    }
    public void setAdminPriId(int adminPriId) {
        this.adminPriId = adminPriId;
    }
    public String getAdminName() {
        return adminName;
    }
    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }
    public String getPriName() {
        return priName;
    }
    public void setPriName(String priName) {
        this.priName = priName;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getUrlPath() {
        return urlPath;
    }
    public void setUrlPath(String urlPath) {
        this.urlPath = urlPath;
    }
    public int getPrivilegeId() {
        return privilegeId;
    }
    public void setPrivilegeId(int privilegeId) {
        this.privilegeId = privilegeId;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public Date getUpdateTime() {
        return updateTime;
    }
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
    public Boolean getReadable() {
        return readable;
    }
    public void setReadable(Boolean readable) {
        this.readable = readable;
    }
    public Boolean getWritable() {
        return writable;
    }
    public void setWritable(Boolean writable) {
        this.writable = writable;
    }
}
