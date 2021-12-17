package com.example.spidercommunity.funs.admin.info;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Date;
import java.sql.Timestamp;

public class Admin {
    private String admin_id;
    private String admin_name;
    private String admin_avatar;
    private Integer admin_sex;

    @JsonFormat(pattern = "yyyy-MM-dd",timezone="GMT+8")
    private Date admin_birthday;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Timestamp admin_register;

    private String worker_id;
    private String role_id;
    private String user_id;

    public String getAdmin_id() {
        return admin_id;
    }

    public void setAdmin_id(String admin_id) {
        this.admin_id = admin_id;
    }

    public String getAdmin_name() {
        return admin_name;
    }

    public void setAdmin_name(String admin_name) {
        this.admin_name = admin_name;
    }

    public String getAdmin_avatar() {
        return admin_avatar;
    }

    public void setAdmin_avatar(String admin_avatar) {
        this.admin_avatar = admin_avatar;
    }

    public Integer getAdmin_sex() {
        return admin_sex;
    }

    public void setAdmin_sex(Integer admin_sex) {
        this.admin_sex = admin_sex;
    }

    public Date getAdmin_birthday() {
        return admin_birthday;
    }

    public void setAdmin_birthday(Date admin_birthday) {
        this.admin_birthday = admin_birthday;
    }

    public Timestamp getAdmin_register() {
        return admin_register;
    }

    public void setAdmin_register(Timestamp admin_register) {
        this.admin_register = admin_register;
    }

    public String getWorker_id() {
        return worker_id;
    }

    public void setWorker_id(String worker_id) {
        this.worker_id = worker_id;
    }

    public String getRole_id() {
        return role_id;
    }

    public void setRole_id(String role_id) {
        this.role_id = role_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
}
