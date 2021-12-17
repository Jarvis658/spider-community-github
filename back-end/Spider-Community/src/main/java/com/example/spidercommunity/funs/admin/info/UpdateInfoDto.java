package com.example.spidercommunity.funs.admin.info;

import com.fasterxml.jackson.annotation.JsonFormat;

public class UpdateInfoDto {
    int id;
    String name;
    int sex;
    String avatar;
    @JsonFormat(pattern = "yyyy-MM-dd ",timezone="GMT+8") //说明输出日期输出json的格式
    String birthday;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }



}
