package com.crossd.service.impl;

import com.crossd.bean.ImgUrl;
import com.crossd.domain.Share;
import com.crossd.mapper.ShareMapper;
import com.crossd.service.ShareService;
import com.github.pagehelper.PageHelper;
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
    public List<Share> pageShare(Share share, int pageNo, int pageSize) {

        PageHelper.startPage(pageNo,pageSize);

        List<Share> shares =  shareMapper.listAllShare();
        return  shares;
    }

    @Override
    public List<ImgUrl> pageShareImgs(int pageNo, int pageSize) {
        PageHelper.startPage(pageNo,pageSize);

        List<Share> shares =  shareMapper.listAllShare();

        List<ImgUrl> imgUrlList = new ArrayList<ImgUrl>();
        //将多张图片处理成单张图片
        for (Share share : shares) {

            String imgs = share.getImgs();
            String[] imgArray = imgs.split(",");
            for (int i = 0; i < imgArray.length ;i ++){

                ImgUrl imgUrl = new ImgUrl(share.getId(), HTTP_IMAGE_CROSSD_ME + imgArray[i]);
                imgUrlList.add(imgUrl);
            }

        }

        return imgUrlList;

    }
}
