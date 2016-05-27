package com.crossd.controller;

import junit.framework.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by nicholas.liu on 2016/5/27.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/crossd-context.xml")
public class ShareControllerTest {

    @Autowired
    ShareController shareController;

    @Test
    public void testData(){

        Object data = shareController.data(1,10);

        System.out.println(data.toString());

        Assert.assertNotNull(data);

    }
}