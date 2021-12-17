package com.example.spidercommunity.funs.user.favorites;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Timestamp;

public class Collect {

    private Integer post_id;
    private Integer user_id;
    private Integer collect_id;
    private Integer collect_group_id;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Timestamp collect_time;

    public Integer getPost_id() {
        return post_id;
    }

    public void setPost_id(Integer post_id) {
        this.post_id = post_id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Integer getCollect_id() {
        return collect_id;
    }

    public void setCollect_id(Integer collect_id) {
        this.collect_id = collect_id;
    }

    public Integer getCollect_group_id() {
        return collect_group_id;
    }

    public void setCollect_group_id(Integer collect_group_id) {
        this.collect_group_id = collect_group_id;
    }

    public Timestamp getCollect_time() {
        return collect_time;
    }

    public void setCollect_time(Timestamp collect_time) {
        this.collect_time = collect_time;
    }
}
