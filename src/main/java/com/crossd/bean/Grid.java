package com.crossd.bean;

/**
 * Created by wise.wu on 15-8-28.
 */

import java.util.List;

public class Grid<T> {

    private static final int MAX_ROW_NUMBER = 50;
    private static final int DEFAULT_ROW_NUMBER = 20;

    /** 总记录数 */
    private Integer records;
    /** 总页数 */
    private Integer total;
    /** 当前页 */
    private Integer page;
    /** 数据 */
    private List<T> rows;

    /** 当前页记录数  */
    private Integer pageRowNumber;

    public Integer getPageRowNumber() {
        return pageRowNumber;
    }

    public void setPageRowNumber(Integer pageRowNumber) {
        this.pageRowNumber = pageRowNumber;
    }

    public Integer getRecords() {
        return records;
    }

    public void setRecords(Integer records) {
        this.records = records;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    public void countPage(int totalNum,Integer requestPage,Integer requestRows){
        if (requestPage!=null) {
            page = requestPage.intValue();
        }else{
            page = 1;
        }
        int rowNumber = DEFAULT_ROW_NUMBER;
        if(requestRows!=null){
            rowNumber = requestRows.intValue();
            if (rowNumber>MAX_ROW_NUMBER) {
                rowNumber = DEFAULT_ROW_NUMBER;
            }
        }
        pageRowNumber = rowNumber;
        total = totalNum%rowNumber == 0 ? totalNum/rowNumber : totalNum/rowNumber +1;
        records = totalNum;
    }

}
