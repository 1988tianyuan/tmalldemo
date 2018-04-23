package com.liugeng.tmalldemo.pojo;

public class User {
    private Integer id;

    private String name;

    private String password;

    private String anonymousName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getAnonymousName() {
        return anonymousName;
    }

    public void setAnonymousName(String anonymousName) {
        this.anonymousName = anonymousName;
    }

    public void setAnonymousName(){
        if(null==name)anonymousName = null;
        if(name.length()<=1)anonymousName = "*";
        if(name.length()==2)anonymousName = name.substring(0,2)+"*";
        char[] chars = name.toCharArray();
        for(int i = 1; i < name.length()-1; i++){
            chars[i] = '*';
        }
        anonymousName = new String(chars);
    }
}