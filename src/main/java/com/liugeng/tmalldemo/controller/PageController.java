package com.liugeng.tmalldemo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("")
public class PageController {
    @RequestMapping("accessRegisterPage")
    public String accessRegisterPage(){
        return "fore/register";
    }

    @RequestMapping("registerSuccess")
    public String registerSuccess(){
        return "fore/registerSuccess";
    }

    @RequestMapping("loginPage")
    public String login(){
        return "fore/login";
    }
}
