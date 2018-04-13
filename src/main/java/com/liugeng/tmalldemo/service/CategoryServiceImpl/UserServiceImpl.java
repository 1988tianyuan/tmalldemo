package com.liugeng.tmalldemo.service.CategoryServiceImpl;

import com.liugeng.tmalldemo.mapper.UserMapper;
import com.liugeng.tmalldemo.pojo.User;
import com.liugeng.tmalldemo.pojo.UserExample;
import com.liugeng.tmalldemo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService{
    @Autowired
    UserMapper userMapper;

    @Override
    public void add(User user) {
        userMapper.insertSelective(user);
    }

    @Override
    public void delete(int uid) {
        userMapper.deleteByPrimaryKey(uid);
    }

    @Override
    public void update(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    @Override
    public User get(int uid) {
        return userMapper.selectByPrimaryKey(uid);
    }

    @Override
    public User get(String name, String password){
        UserExample userExample = new UserExample();
        userExample.createCriteria().andNameEqualTo(name).andPasswordEqualTo(password);
        List<User> userList = userMapper.selectByExample(userExample);
        if(userList.isEmpty()){
            return null;
        }else {
            return userList.get(0);
        }
    }

    @Override
    public List<User> list() {
        UserExample userExample = new UserExample();
        userExample.setOrderByClause("id ASC");
        return userMapper.selectByExample(userExample);
    }

    @Override
    public boolean nameCheck(String name) {
        UserExample userExample = new UserExample();
        userExample.createCriteria().andNameEqualTo(name);
        if(userMapper.selectByExample(userExample).isEmpty()){
            return true;
        }
        return false;
    }


}
