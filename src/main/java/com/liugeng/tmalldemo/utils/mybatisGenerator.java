package com.liugeng.tmalldemo.utils;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;


import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class mybatisGenerator {
    public static void main(String[] args) throws Exception{
        /**
         * 以下代码提供的机制能够防止后续随意重复生成代码
         * */
        String initialDate = "2018-04-01";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date initialDay = simpleDateFormat.parse(initialDate);
        Date today = new Date();
        System.out.println(today);
        if(today.getTime()>initialDay.getTime()+1000*60*60*24){
            System.out.println("----禁止运行！----");
            System.out.println("----想继续运行的话请把initialDate改成最新时间----");
            return;
        }

        /**
         * 以下代码读取generatorConfig.xml配置文件并生成MyBatisGenerator对象，启动逆向构建
         * */
        List<String> warnings = new ArrayList<>();
        boolean overwrite = true;
        InputStream generatorInputStream = mybatisGenerator.class.getClassLoader().getResource("generatorConfig.xml").openStream();
        ConfigurationParser configurationParser = new ConfigurationParser(warnings);
        Configuration configuration = configurationParser.parseConfiguration(generatorInputStream);
        generatorInputStream.close();
        DefaultShellCallback callback = new DefaultShellCallback(overwrite);
        MyBatisGenerator mybatisGenerator = new MyBatisGenerator(configuration, callback, warnings);
        mybatisGenerator.generate(null);

        System.out.println("生成代码成功，只能执行一次，以后执行会覆盖掉mapper,pojo,xml 等文件上做的修改");
    }
}
