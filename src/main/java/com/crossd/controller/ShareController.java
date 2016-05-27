package com.crossd.controller;

import com.crossd.bean.Grid;
import com.crossd.domain.Share;
import com.crossd.service.ShareService;
import com.crossd.tools.JsonTimeFormatConfig;
import com.github.pagehelper.Page;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by nicholas.liu on 2016/5/27.
 */
@Controller
@RequestMapping("/share")
public class ShareController {

    @Autowired
    ShareService shareService;

    /**
     * 跳转jsp
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() throws Exception {
        return "jinniu/share";
    }


    /**
     * 加载列表数据
     * @param pageNo  当前页 从第1页开始
     * @param pageSize  每页大小
     * @return
     */
    @ResponseBody
    @RequestMapping(value = { "/data" }, method = RequestMethod.GET)
    public Object data(@RequestParam("page") int pageNo,
                       @RequestParam("rows") int pageSize){

        Page<Share> pages = (Page<Share>)shareService.pageShare(null, pageNo, pageSize);

        //转化成页面需要参数
        Grid<Share> shareGrid = new Grid<Share>();
        shareGrid.setRows(pages);
        shareGrid.setPage(pages.getPageNum());
        shareGrid.setTotal(pages.getPages());
        shareGrid.setRecords((int)pages.getTotal());

        JSONObject jsonObject = JSONObject.fromObject(shareGrid, JsonTimeFormatConfig.getJsonConfig());

        System.out.println(jsonObject.toString());
        return jsonObject.toString();
    }
}
