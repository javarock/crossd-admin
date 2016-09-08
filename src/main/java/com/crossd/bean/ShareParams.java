package com.crossd.bean;

/**
 * Created by nicholas.liu on 2016/6/14.
 */
public class ShareParams {
    private int id ;
    private int userId;
    private String status;



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ShareParams{" +
                "id=" + id +
                ", userId=" + userId +
                ", status=" + status +
                '}';
    }
}
