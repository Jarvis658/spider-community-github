package com.example.spidercommunity.funs.admin.post;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Timestamp;

public class APSearchResult {
    private String post_id;
    private String user_id;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8") //说明输出日期输出json的格式
    private Timestamp post_time;

    private String post_title;
    private String post_content;
    private Integer post_like_number;
    private Integer comment_number;
    private String user_name;
    private String user_avatar;


    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public Timestamp getPost_time() {
        return post_time;
    }

    public void setPost_time(Timestamp post_time) {
        this.post_time = post_time;
    }

    public String getPost_title() {
        return post_title;
    }

    public void setPost_title(String post_title) {
        this.post_title = post_title;
    }

    public String getPost_content() {
        return post_content;
    }

    public void setPost_content(String post_content) {
        this.post_content = post_content;
    }

    public Integer getPost_like_number() {
        return post_like_number;
    }

    public void setPost_like_number(Integer post_like_number) {
        this.post_like_number = post_like_number;
    }

    public Integer getComment_number() {
        return comment_number;
    }

    public void setComment_number(Integer comment_number) {
        this.comment_number = comment_number;
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

}