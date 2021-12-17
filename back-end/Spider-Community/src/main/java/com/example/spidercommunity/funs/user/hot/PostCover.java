package com.example.spidercommunity.funs.user.hot;

import java.util.Date;

public class PostCover {
    private String post_title;
    private String cover_image;
    private String user_name;
    private int post_like_number;
    private String user_id;
    private String post_id;
    private int diff;
    private double calculate;
    private Date post_time;
    private int like_status;
    private String user_avatar;

    public String getPost_title() {
        return post_title;
    }

    public void setPost_title(String post_title) {
        this.post_title = post_title;
    }

    public String getCover_image() {
        return cover_image;
    }

    public void setCover_image(String cover_image) {
        this.cover_image = cover_image;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public int getPost_like_number() {
        return post_like_number;
    }

    public void setPost_like_number(int post_like_number) {
        this.post_like_number = post_like_number;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public double getCalculate() {
        return calculate;
    }

    public void setCalculate(double calculate) {
        this.calculate = calculate;
    }

    public Date getPost_time() {
        return post_time;
    }

    public void setPost_time(Date post_time) {
        this.post_time = post_time;
    }

    public int getDiff() {
        return diff;
    }

    public void setDiff(int diff) {
        this.diff = diff;
    }

    public int getLike_status() {
        return like_status;
    }

    public void setLike_status(int like_status) {
        this.like_status = like_status;
    }

    public String getUser_avatar() {
        return user_avatar;
    }

    public void setUser_avatar(String user_avatar) {
        this.user_avatar = user_avatar;
    }
}
