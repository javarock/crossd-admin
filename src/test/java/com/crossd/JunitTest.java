package com.crossd;

import com.crossd.domain.Admin;
import com.crossd.service.impl.AdminServiceImpl;
import junit.framework.Assert;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * Created by nicholas.liu on 2016/5/24.
 */
public class JunitTest {

    @Test
    public void testService(){

        ClassPathXmlApplicationContext classPathXmlApplicationContext =  new ClassPathXmlApplicationContext("crossd-context.xml");

        AdminServiceImpl adminServiceImpl = (AdminServiceImpl)classPathXmlApplicationContext.getBean("adminServiceImpl");

        Admin admin = adminServiceImpl.login("admin", "123456");
        Assert.assertNotNull(admin);

    }

}
