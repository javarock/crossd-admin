package com.crossd.bean;

/**
 * Created by wise.wu on 15-8-28.
 */
public class SuccessData<T> {

    private boolean success;
    private T data;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
