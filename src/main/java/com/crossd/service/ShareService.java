package com.crossd.service;

import com.crossd.bean.RichShare;
import com.crossd.bean.ShareParams;
import com.crossd.domain.Share;
import com.github.pagehelper.Page;

/**
 * Created by nicholas.liu on 2016/5/25.
 */
public interface ShareService {

    /**
     * 使用分页插件，分页查询 获取page对象
     * @param shareParams
     * @param pageNo
     * @param pageSize
     * @return
     */
     Page<Share> pageShare(ShareParams shareParams, int pageNo, int pageSize);

     Page<RichShare> pageRichShareImgs(int pageNo, int pageSize);

    /**
     * 修改状态
     * @param shareId
     * @param from
     * @param to
     */
     void updateShareStatus(int shareId, int from, int to);


     void delShare(int shareId);

    void delComment(int shareId);

    void delPraise(int shareId);
}
