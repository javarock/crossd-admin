package com.crossd.controller;

/**
 * Created by wise.wu on 15-8-28.
 */

import com.crossd.bean.Constant;
import com.crossd.bean.Grid;
import com.crossd.bean.Success;
import com.crossd.bean.SuccessData;
import com.crossd.callback.ControllerCallback;
import com.crossd.domain.Admin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;


public class BaseController {

    private static final Logger logger = LoggerFactory.getLogger(BaseController.class);

    /** HttpServletRequest */
    protected HttpServletRequest request;
    /** HttpServletResponse */
    protected HttpServletResponse response;
    /** HttpSession */
    protected HttpSession session;

    //userName参数在AOP时用到，记录用户操作记录
    protected Admin admin;
    protected String userName;

    /**
     * 使用了@ModelAttribute注解之后，再执行controller之前，都会先执行这个方法<br>
     * 此方法会初始化HttpServletRequest、HttpServletResponse、HttpSession
     *
     * @param request
     * @param response
     */
    @ModelAttribute
    public void initHttp(HttpServletRequest request,
                         HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession();
        admin = (Admin)session.getAttribute(Constant.admin_session_key);
        if (admin != null){
            userName = admin.getAdminName();
        }
    }


    protected <T> void countPageParam(Grid<T> grid, Map<String, Object> paramMap){
        int page = grid.getPage();
        int rows = grid.getPageRowNumber();
        int totalNum = grid.getRecords();
        int from = (page-1) * rows;
        int number = totalNum - page*rows > 0 ? rows : totalNum - (page-1)*rows;

        paramMap.put("from", from);
        paramMap.put("number", number);
    }

    /**
     * 模板方法，适合在执行操作后返回的json数据为:{"success":"true/false"}
     *
     * @param controllerCallback
     * @throws IOException
     */
    protected Success executeSuccess(ControllerCallback controllerCallback) {
        Success success = new Success();
        try {
            success.setSuccess(controllerCallback.doSuccessService());
        } catch (Exception e) {
            e.printStackTrace();
            // TODO log error
            success.setSuccess(false);
        }
        return success;
    }

    /**
     * 模板方法，适合在执行操作后返回的json数据为:某个对象的json数据，以及{"success":"true/false"}的标识
     *
     * @param controllerCallback
     * @return
     */
    protected <T> SuccessData<T> executeData(
            ControllerCallback controllerCallback) {
        SuccessData<T> successData = new SuccessData<T>();
        try {
            T data = controllerCallback.doDataService();
            successData.setData(data);
            successData.setSuccess(true);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error(e.getMessage());
            successData.setSuccess(false);
        }
        return successData;

    }

    /**
     * 模板方法，适合在执行操作后返回的数据为:分页展示的json
     *
     * @param controllerCallback
     * @throws IOException
     */
    protected <T> Grid<T> executeGrid(ControllerCallback controllerCallback) {
        Grid<T> grid = null;
        try {
            grid = controllerCallback.doPageService();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return grid;
    }

}
