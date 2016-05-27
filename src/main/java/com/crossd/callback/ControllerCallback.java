package com.crossd.callback;

/**
 * Created by wise.wu on 15-8-28.
 */
public interface ControllerCallback {

    /**
     * controller执行后的回调，真正执行controller核心逻辑的地方
     *
     * @param
     */
    // <T> T doService() throws Exception;

    boolean doSuccessService() throws Exception;

    <T> T doDataService() throws Exception;

    <T> T doPageService() throws Exception;

}
