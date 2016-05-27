package com.crossd.domain;

/**
 * Created by wise.wu on 15-9-1.
 */

import org.apache.ibatis.type.Alias;

/**
 * id,operateTime由数据库自动生成，无须设置
 * userName,operate,description
 */
@Alias("SystemLog")
public class SystemLog {

    private Integer id;
    private String userName;
    private String operateModule;
    private String operate;
    private String operateTime;
    private String className;
    private String description;

    public String getOperateModule() {
        return operateModule;
    }

    public void setOperateModule(String operateModule) {
        this.operateModule = operateModule;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getOperate() {
        return operate;
    }

    public void setOperate(String operate) {
        this.operate = operate;
    }


    public String getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(String operateTime) {
        this.operateTime = operateTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
