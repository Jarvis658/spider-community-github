package com.example.spidercommunity.funs.user.interaction;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Timestamp;

public class PostLike {
    private  Integer post_like_id;
    private  Integer post_id;
    private  Integer user_id;
    private  String user_name;
    private String user_avatar;
    private  String post_title;

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

    public String getPost_title() {
        return post_title;
    }

    public void setPost_title(String post_title) {
        this.post_title = post_title;
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private Timestamp like_time;

    public Integer getPost_like_id() {
        return post_like_id;
    }

    public void setPost_like_id(Integer post_like_id) {
        this.post_like_id = post_like_id;
    }

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

    public Timestamp getLike_time() {
        return like_time;
    }

    public void setLike_time(Timestamp like_time) {
        this.like_time = like_time;
    }
}
