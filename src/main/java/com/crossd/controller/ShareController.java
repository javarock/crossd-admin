package com.crossd.controller;

import com.crossd.bean.Grid;
import com.crossd.bean.RichShare;
import com.crossd.bean.Status;
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

        Page<Share> pages = shareService.pageShare(null, pageNo, pageSize);

        //转化成页面需要参数
        Grid<Share> shareGrid = new Grid<Share>();
        shareGrid.setRows(pages);
        shareGrid.setPage(pages.getPageNum());
        shareGrid.setTotal(pages.getPages());
        shareGrid.setRecords((int)pages.getTotal());

        JSONObject jsonObject = JSONObject.fromObject(shareGrid, JsonTimeFormatConfig.getJsonConfig());

        return jsonObject.toString();
    }

    /**
     * 跳转jsp
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/listImgsList", method = RequestMethod.GET)
    public String listImgsList() throws Exception {
        return "jinniu/shareImgsList";
    }

    /**
     * 加载列表数据
     * @param pageNo  当前页 从第1页开始
     * @param pageSize  每页大小
     * @return
     */
    @ResponseBody
    @RequestMapping(value = { "/dataImgs" }, method = RequestMethod.GET)
    public Object dataImgs(@RequestParam("page") int pageNo,
                       @RequestParam("rows") int pageSize,
                           RichShare richShare){

        int id = richShare.getId();
        int userId = richShare.getUserId();
        String img1 = richShare.getImg1();



        Page<RichShare> imgUrls = shareService.pageRichShareImgs(pageNo, pageSize);

        //转化成页面需要参数
        Grid<RichShare> shareGrid = new Grid<RichShare>();
        shareGrid.setRows(imgUrls);
        shareGrid.setPage(imgUrls.getPageNum());
        shareGrid.setTotal(imgUrls.getPages());
        shareGrid.setRecords((int)imgUrls.getTotal());

        JSONObject jsonObject = JSONObject.fromObject(shareGrid, JsonTimeFormatConfig.getJsonConfig());

        return jsonObject.toString();
    }

    /**
     * 下架分享动态
     * @param shareId
     */
    @ResponseBody
    @RequestMapping(value = {"/downOperate"},method = RequestMethod.POST)
    public void  downOperate(@RequestParam("rowId") int shareId){

        shareService.updateShareStatus(shareId, Status.UP,Status.DOWN);

    }

    /**
     * 下架分享动态
     * @param shareId
     */
    @ResponseBody
    @RequestMapping(value = {"/upOperate"},method = RequestMethod.POST)
    public void  upOperate(@RequestParam("rowId") int shareId){

        shareService.updateShareStatus(shareId, Status.DOWN,Status.UP);

    }



    /**
     * 跳转jsp
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/listImgs", method = RequestMethod.GET)
    public String listImgs() throws Exception {
        return "jinniu/shareImgs";
    }
}
