package cn.njxzc.bysj.common;

import java.io.Serializable;

public class TableResponse<T> implements Serializable {

    private int code;
    private String msg;
    private int count;
    private T data;

    private TableResponse(int code) {
        this.code = code;
    }

    public TableResponse(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public TableResponse(int code, T data) {
        this.code = code;
        this.data = data;
    }

    public TableResponse(int code, int count, T data) {
        this.code = code;
        this.count = count;
        this.data = data;
    }

    public TableResponse(int code, String msg, int count, T data) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", count=" + count +
                ", data=" + data +
                '}';
    }
}
