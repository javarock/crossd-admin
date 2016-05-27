package com.crossd.domain;

import org.apache.ibatis.type.Alias;

import java.io.Serializable;

/**
 * Created by nicholas.liu on 2016/5/25.
 */
@Alias("Share")
public class Share implements Serializable {

    private int id;
    private String imgs;
    private String description;
    private int praiseCount;      //被赞数
    private int scanCount;        //浏览数
    private int commentCount;     //评论数
    private int userId;           //
    private int status;
    private int topicId;          //话题id
    private int createTime;

    @Override
    public String toString() {
        return "Share{" +
                "id=" + id +
                ", imgs='" + imgs + '\'' +
                ", description='" + description + '\'' +
                ", praiseCount=" + praiseCount +
                ", scanCount=" + scanCount +
                ", commentCount=" + commentCount +
                ", userId=" + userId +
                ", status=" + status +
                ", topicId=" + topicId +
                ", createTime=" + createTime +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPraiseCount() {
        return praiseCount;
    }

    public void setPraiseCount(int praiseCount) {
        this.praiseCount = praiseCount;
    }

    public int getScanCount() {
        return scanCount;
    }

    public void setScanCount(int scanCount) {
        this.scanCount = scanCount;
    }

    public int getCommentCount() {
        return commentCount;
    }

    public void setCommentCount(int commentCount) {
        this.commentCount = commentCount;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getTopicId() {
        return topicId;
    }

    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    public int getCreateTime() {
        return createTime;
    }

    public void setCreateTime(int createTime) {
        this.createTime = createTime;
    }
}
