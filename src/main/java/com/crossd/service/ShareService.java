package com.crossd.service;

import com.crossd.domain.Share;

import java.util.List;

/**
 * Created by nicholas.liu on 2016/5/25.
 */
public interface ShareService {

    /**
     * 使用分页插件，分页查询 获取page对象
     * @param share
     * @param pageNo
     * @param pageSize
     * @return
     */
     List<Share> pageShare(Share share, int pageNo, int pageSize);
}
