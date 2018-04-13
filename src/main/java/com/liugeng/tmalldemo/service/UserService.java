package com.liugeng.tmalldemo.service;

import com.liugeng.tmalldemo.pojo.User;

import java.util.List;

public interface UserService {
    void add(User user);
    void delete(int uid);
    void update(User user);
    User get(int uid);
    User get(String name, String password);
    List<User> list();
    boolean nameCheck(String name);
}
