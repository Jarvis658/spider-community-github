package com.example.spidercommunity.funs.admin.users;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Timestamp;

public class AUSearchResult {

 String user_id;
 String user_name;
 @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8")
 String user_birthday;

 String user_avatar;
 String user_signature;
 String user_sex;
 String user_school;
 String role_id;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8") //说明输出日期输出json的格式
 String register_time;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8") //说明输出日期输出json的格式
 String recent_login;
 String fans_number;

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_birthday() {
        return user_birthday;
    }

    public void setUser_birthday(String user_birthday) {
        this.user_birthday = user_birthday;
    }

    public String getUser_avatar() {
        return user_avatar;
    }

    public void setUser_avatar(String user_avatar) {
        this.user_avatar = user_avatar;
    }

    public String getUser_signature() {
        return user_signature;
    }

    public void setUser_signature(String user_signature) {
        this.user_signature = user_signature;
    }

    public String getUser_sex() {
        return user_sex;
    }

    public void setUser_sex(String user_sex) {
        this.user_sex = user_sex;
    }

    public String getUser_school() {
        return user_school;
    }

    public void setUser_school(String user_school) {
        this.user_school = user_school;
    }

    public String getRole_id() {
        return role_id;
    }

    public void setRole_id(String role_id) {
        this.role_id = role_id;
    }

    public String getRegister_time() {
        return register_time;
    }

    public void setRegister_time(String register_time) {
        this.register_time = register_time;
    }

    public String getRecent_login() {
        return recent_login;
    }

    public void setRecent_login(String recent_login) {
        this.recent_login = recent_login;
    }

    public String getFans_number() {
        return fans_number;
    }

    public void setFans_number(String fans_number) {
        this.fans_number = fans_number;
    }

    public String getAttention_number() {
        return attention_number;
    }

    public void setAttention_number(String attention_number) {
        this.attention_number = attention_number;
    }

    String attention_number;




}