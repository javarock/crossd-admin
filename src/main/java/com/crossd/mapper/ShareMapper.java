package com.crossd.mapper;

import com.crossd.bean.RichShare;
import com.crossd.domain.Share;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by nicholas.liu on 2016/5/25.
 */
public interface ShareMapper {

    /**
     * 分页列表share
     * @return
     */
    List<Share>  listAllShare();

    /**
     * 分页列表share
     * @return
     */
    List<RichShare>  listAllRichShare();

    void updateShareStatus(@Param("shareId") int shareId, @Param("from") int from, @Param("to") int to);
}
