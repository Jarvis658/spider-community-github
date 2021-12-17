package com.example.spidercommunity.funs.user.info;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
    private String user_id;
    private String user_name;
    private String user_avatar;
    private Integer user_sex;
    private String user_signature;
    private String school_name;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8")
    private Date user_birthday;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Timestamp register_time;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Timestamp recent_login;

    private Integer fans_number;
    private Integer attention_number;
    private String role_id;


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

    public String getUser_avatar() {
        return user_avatar;
    }

    public void setUser_avatar(String user_avatar) {
        this.user_avatar = user_avatar;
    }

    public Integer getUser_sex() {
        return user_sex;
    }

    public void setUser_sex(Integer user_sex) {
        this.user_sex = user_sex;
    }

    public String getUser_signature() {
        return user_signature;
    }

    public void setUser_signature(String user_signature) {
        this.user_signature = user_signature;
    }

    public String getSchool_name() {
        return school_name;
    }

    public void setSchool_name(String user_school) {
        this.school_name = user_school;
    }

    public Date getUser_birthday() {
        return user_birthday;
    }

    public void setUser_birthday(Date user_birthday) {
        this.user_birthday = user_birthday;
    }

    public Timestamp getRegister_time() {
        return register_time;
    }

    public void setRegister_time(Timestamp register_time) {
        this.register_time = register_time;
    }

    public Timestamp getRecent_login() {
        return recent_login;
    }

    public void setRecent_login(Timestamp recent_login) {
        this.recent_login = recent_login;
    }

    public Integer getFans_number() {
        return fans_number;
    }

    public void setFans_number(Integer fans_number) {
        this.fans_number = fans_number;
    }

    public Integer getAttention_number() {
        return attention_number;
    }

    public void setAttention_number(Integer attention_number) {
        this.attention_number = attention_number;
    }

    public String getRole_id() {
        return role_id;
    }

    public void setRole_id(String role_id) {
        this.role_id = role_id;
    }
}
