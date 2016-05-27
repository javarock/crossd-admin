package com.crossd.dao;

import java.util.List;
import java.util.Map;

/**
 * Created by wise.wu on 15-8-31.
 */
public interface BaseDao<T> {

    public int countByCriteria(Map<String, Object> paramMap) throws Exception;

    public List<T> listByCriteria(Map<String, Object> paramMap) throws Exception;

    public int add(Map<String, Object> paramMap) throws Exception ;

    public int modify(Map<String, Object> paramMap) throws Exception;
}
