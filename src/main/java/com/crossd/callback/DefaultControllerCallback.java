package com.crossd.callback;

/**
 * Created by wise.wu on 15-8-28.
 */
public class DefaultControllerCallback implements ControllerCallback {

    @Override
    public boolean doSuccessService() throws Exception {
        return false;
    }

    @Override
    public <T> T doPageService() throws Exception {
        return null;
    }

    @Override
    public <T> T doDataService() throws Exception {
        return null;
    }
}
