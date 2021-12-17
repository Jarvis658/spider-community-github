package com.example.spidercommunity.funs.user.favorites;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Timestamp;

public class CollectGroupDto {
    private int collect_group_id;
    private String collect_group_name;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Timestamp create_time;
    private int user_id;
    private int post_number;
    private int display_status;


    public CollectGroupDto(){}

    public CollectGroupDto(int user_id) {
        this.user_id = user_id;
    }

    public int getCollect_group_id() {
        return collect_group_id;
    }

    public void setCollect_group_id(int collect_group_id) {
        this.collect_group_id = collect_group_id;
    }

    public String getCollect_group_name() {
        return collect_group_name;
    }

    public void setCollect_group_name(String collect_group_name) {
        this.collect_group_name = collect_group_name;
    }

    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getPost_number() {
        return post_number;
    }

    public void setPost_number(int post_number) {
        this.post_number = post_number;
    }

    public int getDisplay_status() {
        return display_status;
    }

    public void setDisplay_status(int display_status) {
        this.display_status = display_status;
    }
}
