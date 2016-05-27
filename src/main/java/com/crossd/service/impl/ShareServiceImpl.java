package com.crossd.service.impl;

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

    @Autowired
    ShareMapper shareMapper;


    @Override
    public List<Share> pageShare(Share share, int pageNo, int pageSize) {

        PageHelper.startPage(pageNo,pageSize);

        List<Share> shares =  shareMapper.listAllShare();
        System.out.println("------数据库中查出来的值");
        System.out.println(shares.size());
        System.out.println("-----------------");
        return  shares;
    }
}
