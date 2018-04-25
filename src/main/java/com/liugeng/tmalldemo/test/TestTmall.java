package com.liugeng.tmalldemo.test;

import com.liugeng.tmalldemo.mapper.ProductMapper;
import com.liugeng.tmalldemo.pojo.ProductExample;
import com.liugeng.tmalldemo.pojo.User;
import com.liugeng.tmalldemo.service.CategoryServiceImpl.ProductServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TestTmall {
    public static void main(String args[]){
        Date payDate = new Date(System.currentTimeMillis());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("M月dd日");
        Date predictReceiveDate = new Date(payDate.getTime() + 7*24*3600*1000);
        System.out.println(simpleDateFormat.format(payDate));
        System.out.println(simpleDateFormat.format(predictReceiveDate));



    }

}
