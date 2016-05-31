package com.crossd.service.impl;

import com.crossd.bean.ImgUrl;
import com.crossd.bean.RichShare;
import com.crossd.domain.Share;
import com.crossd.mapper.ShareMapper;
import com.crossd.service.ShareService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by nicholas.liu on 2016/5/25.
 */
@Service
public class ShareServiceImpl implements ShareService {

    public static final String HTTP_IMAGE_CROSSD_ME = "http://image.crossd.me/";
    @Autowired
    ShareMapper shareMapper;


    @Override
    public Page<Share> pageShare(Share share, int pageNo, int pageSize) {

        PageHelper.startPage(pageNo,pageSize);

        List<Share> shares =  shareMapper.listAllShare();
        return  (Page<Share>) shares;
    }

    @Override
    public Page<RichShare> pageRichShareImgs(int pageNo, int pageSize) {
        PageHelper.startPage(pageNo,pageSize);

        List<RichShare> richShares =  shareMapper.listAllRichShare();

        //将多张图片处理成单张图片
        for (RichShare share : richShares) {

            String imgs = share.getImgs();
            if(StringUtils.isBlank(imgs)){
                continue;
            }
            String[] imgArray = imgs.split(",");
            int length = imgArray.length;
            if(length < 2){
                share.setImg1(HTTP_IMAGE_CROSSD_ME + imgArray[0]);
                continue;
            }
            //这段代码太渣 后面了解清楚jqGrid后再修改
            if(length >= 1){
                share.setImg1(HTTP_IMAGE_CROSSD_ME + imgArray[0]);
            }
            if (length >= 2 && StringUtils.isNotBlank(imgArray[1])) {
                share.setImg2(HTTP_IMAGE_CROSSD_ME + imgArray[1]);
            }
            if (length >= 3 && StringUtils.isNotBlank(imgArray[2])) {
                share.setImg3(HTTP_IMAGE_CROSSD_ME + imgArray[2]);
            }
            if (length >= 4 &&  StringUtils.isNotBlank(imgArray[3])) {
                share.setImg4(HTTP_IMAGE_CROSSD_ME + imgArray[3]);
            }
            if (length >= 5 &&  StringUtils.isNotBlank(imgArray[4])) {
                share.setImg5(HTTP_IMAGE_CROSSD_ME + imgArray[4]);
            }
            if (length >= 6 &&  StringUtils.isNotBlank(imgArray[5])) {
                share.setImg6(HTTP_IMAGE_CROSSD_ME + imgArray[5]);
            }
            if (length >= 7 &&  StringUtils.isNotBlank(imgArray[6])) {
                share.setImg7(HTTP_IMAGE_CROSSD_ME + imgArray[6]);
            }
            if (length >= 8 && StringUtils.isNotBlank(imgArray[7])) {
                share.setImg8(HTTP_IMAGE_CROSSD_ME + imgArray[7]);
            }
            if (length >= 9 && StringUtils.isNotBlank(imgArray[8])) {
                share.setImg9(HTTP_IMAGE_CROSSD_ME + imgArray[8]);
            }

        }

        return (Page<RichShare>)richShares;

    }

    @Override
    public void updateShareStatus(int shareId, int from, int to) {
        shareMapper.updateShareStatus(shareId,from,to);
    }
}
