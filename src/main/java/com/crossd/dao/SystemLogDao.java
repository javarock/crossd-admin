package com.crossd.dao;


import com.crossd.domain.SystemLog;

/**
 * Created by wise.wu on 15-9-1.
 */
public interface SystemLogDao extends BaseDao<SystemLog>{

       public int add(SystemLog sl) throws Exception ;

}
