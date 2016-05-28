package com.crossd.bean;

/**
 * Created by nicholas.liu on 2016/5/27.
 */
public class ImgUrl {

    private int id;
    private String imgUrl;

    public ImgUrl(int id, String imgUrl) {
        this.id = id;
        this.imgUrl = imgUrl;
    }

    @Override
    public String toString() {
        return "ImgUrl{" +
                "id=" + id +
                ", imgUrl='" + imgUrl + '\'' +
                '}';
    }
}
