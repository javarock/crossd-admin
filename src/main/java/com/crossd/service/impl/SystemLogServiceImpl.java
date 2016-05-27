package com.crossd.service.impl;

import com.crossd.domain.SystemLog;
import com.crossd.dao.SystemLogDao;
import com.crossd.service.SystemLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by wise.wu on 15-9-7.
 */
@Service
public class SystemLogServiceImpl implements SystemLogService {

    @Autowired
    protected SystemLogDao systemLogDao;

    @Override
    public int countByCriteria(Map<String, Object> paramMap) throws Exception {
        return systemLogDao.countByCriteria(paramMap);
    }

    @Override
    public List<SystemLog> listByCriteria(Map<String, Object> paramMap) throws Exception {
        return systemLogDao.listByCriteria(paramMap);
    }

    @Override
    public int add(Map<String, Object> paramMap, String userName) throws Exception {
        throw new Exception("不支持的方法");
    }

    @Override
    public int modify(Map<String, Object> paramMap, String userName) throws Exception {
        throw new Exception("不支持的方法");
    }
}
