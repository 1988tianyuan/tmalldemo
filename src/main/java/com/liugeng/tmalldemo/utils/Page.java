package com.liugeng.tmalldemo.utils;

public class Page {
    private int start;
    private int count;
    private int total;
    private String param;
    private final int defaultCount = 5;

    public Page(){
        this.count = defaultCount;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    //获取总页数
    public int getTotalPage(){
        int totalPage;
        if(0 == total%count){
            totalPage = total/count;
        }else {
            totalPage = total/count+1;
        }
        if(0==total)totalPage=1;
        return totalPage;
    }

    //获取最后一页的第一个元素的位置
    public int getLast(){
        int last;
        if(0 == total%count){
            last = total-count;
        }else {
            last = total - total%count;
        }
        return  last = last<0?0:last;
    }

    //判断当前页是否是第一页
    public boolean isHasPrevious(){
        boolean hasPrevious;
        if(start==0)return hasPrevious=false;
        return hasPrevious=true;
    }

    //判断当前页是否是最后一页
    public boolean isHasNext(){
        boolean hasNext;
        if(start==getLast())return hasNext=false;
        return hasNext=true;
    }


}
