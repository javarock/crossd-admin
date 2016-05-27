package com.crossd.dao.impl;

import com.crossd.dao.BaseDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by wise.wu on 15-8-31.
 */
@Repository
public class BaseDaoImpl<T> implements BaseDao<T> {

    protected static  String COUNT_BY_CRITERIA = "";
    protected static  String List_BY_CRITERIA = "";
    protected static  String ADD = "";
    protected static  String UPDATE = "";

    @Autowired
    @Qualifier("sqlSessionTemplate")
    protected SqlSessionTemplate coinSqlSessionTemplate;


    @Override
    public int countByCriteria(Map<String, Object> paramMap) throws Exception{
        if ("".equals(COUNT_BY_CRITERIA)){
            throw new Exception("Please Initialization COUNT_BY_CRITERIA Which Extends BaseDaoImpl.java");
        }else{
            return  coinSqlSessionTemplate.selectOne(COUNT_BY_CRITERIA, paramMap);
        }
    }

    @Override
    public List<T> listByCriteria(Map<String, Object> paramMap) throws Exception{
        if ("".equals(List_BY_CRITERIA)){
            throw new Exception("Please Initialization List_BY_CRITERIA Which Extends BaseDaoImpl.java");
        }else{
            return  coinSqlSessionTemplate.selectList(List_BY_CRITERIA, paramMap);
        }
    }

    @Override
    public int add(Map<String, Object> paramMap) throws Exception{
        if ("".equals(ADD)){
            throw new Exception("Please Initialization ADD Which Extends BaseDaoImpl.java");
        }else{
            return  coinSqlSessionTemplate.insert(ADD, paramMap);
        }
    }

    @Override
    public int modify(Map<String, Object> paramMap) throws Exception{
        if ("".equals(UPDATE)){
            throw new Exception("Please Initialization UPDATE Which Extends BaseDaoImpl.java");
        }else{
            return coinSqlSessionTemplate.update(UPDATE,paramMap);
        }
    }
}
