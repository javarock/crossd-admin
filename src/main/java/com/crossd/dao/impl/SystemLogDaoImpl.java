package com.crossd.dao.impl;

import com.crossd.domain.SystemLog;
import com.crossd.dao.SystemLogDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by wise.wu on 15-9-1.
 */
@Repository
public class SystemLogDaoImpl implements SystemLogDao {


    private static final String ADD = "jinniu.systemLog.add";
    private static final String COUNT_BY_CRITERIA = "jinniu.systemLog.countAllByCriteria";
    private static final String List_BY_CRITERIA = "jinniu.systemLog.listAllByCriteria";


    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate coinSqlSessionTemplate;

    @Override
    public int add(SystemLog sl) throws Exception {
        return coinSqlSessionTemplate.insert(ADD,sl);
    }


    @Override
    public int countByCriteria(Map<String, Object> paramMap) throws Exception {
        return coinSqlSessionTemplate.selectOne(COUNT_BY_CRITERIA, paramMap);
    }

    @Override
    public List<SystemLog> listByCriteria(Map<String, Object> paramMap) throws Exception {
        return coinSqlSessionTemplate.selectList(List_BY_CRITERIA, paramMap);
    }

    @Override
    public int add(Map<String, Object> paramMap) throws Exception {
        throw new Exception("不支持的方法");
    }

    @Override
    public int modify(Map<String, Object> paramMap) throws Exception {
        throw new Exception("不支持的方法");
    }
}
