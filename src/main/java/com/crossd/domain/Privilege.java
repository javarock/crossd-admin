package com.crossd.domain;

import org.apache.ibatis.type.Alias;

/**
 * Created by wise.wu on 15-8-28.
 */
@Alias("Privilege")
public class Privilege {
    private int priId;
    private String priName;
    private String description;
    private String urlPath;

    public int getPriId() {
        return priId;
    }
    public void setPriId(int priId) {
        this.priId = priId;
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

}
