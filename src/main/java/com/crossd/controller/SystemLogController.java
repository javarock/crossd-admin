package com.crossd.controller;

import com.crossd.bean.Grid;
import com.crossd.callback.DefaultControllerCallback;
import com.crossd.domain.SystemLog;
import com.crossd.service.SystemLogService;
import com.crossd.tools.JsonTimeFormatConfig;
import com.crossd.tools.Tools;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created by wise.wu on 15-9-7.
 */

@Controller
@RequestMapping("/systemLog")
public class SystemLogController extends BaseController {

    @Autowired
    private SystemLogService service;


    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() throws Exception {
        return "jinniu/systemLogList";
    }

    @ResponseBody
    @RequestMapping(value = { "/data" }, method = RequestMethod.GET)
    public Object data(final Integer page, final Integer rows, SystemLog cm) throws Exception {

        final Map<String, Object> paramMap = buildParamMap(cm);

        Grid<SystemLog> grid = executeGrid(new DefaultControllerCallback() {
            @SuppressWarnings("unchecked")
            @Override
            public Grid<SystemLog> doPageService() throws Exception {
                Grid<SystemLog> grid = new Grid<SystemLog>();
                int totalNum = service.countByCriteria(paramMap);
                grid.countPage(totalNum, page, rows);
                countPageParam(grid, paramMap);
                grid.setRows(service.listByCriteria(paramMap));
                return grid;
            }

            private void countPageParam(Grid<SystemLog> grid, Map<String, Object> paramMap) {
                int page = grid.getPage();
                int rows = grid.getPageRowNumber();
                int totalNum = grid.getRecords();
                int from = (page - 1) * rows;
                int number = totalNum - page * rows > 0 ? rows : totalNum - (page - 1) * rows;
                paramMap.put("from", from);
                paramMap.put("number", number);
            }
        });
        return JSONObject.fromObject(grid, JsonTimeFormatConfig.getJsonConfig());
    }


    private Map<String, Object> buildParamMap(SystemLog cm){

        Map<String, Object> map = new LinkedHashMap<String, Object>();
        map.put("id",cm.getId());
        map.put("userName",cm.getUserName());
        map.put("operateModule",cm.getOperateModule());
        map.put("operate",cm.getOperate());
        map.put("operateTime", Tools.getDateTime(cm.getOperateTime()));
        map.put("className",cm.getClassName());
        map.put("description",cm.getDescription());

        return map;

    }

}
