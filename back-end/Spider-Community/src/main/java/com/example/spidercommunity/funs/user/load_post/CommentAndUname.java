package com.example.spidercommunity.funs.user.load_post;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.sql.Timestamp;

public class CommentAndUname {
    private String comment_id;
    private Integer comment_like_number;
    private String comment_content;
    private Integer user_id;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss") //说明输出日期输出json的格式
    private Timestamp comment_time;
    private String user_name;
    private String user_avatar;
    private Integer like_status;
    private Integer sub_comment_number;
    private String post_id;
    private String parent_comment_id;

    public Integer getLike_status() {
        return like_status;
    }

    public void setLike_status(Integer like_status) {
        this.like_status = like_status;
    }

    public String getComment_id() {
        return comment_id;
    }

    public void setComment_id(String comment_id) {
        this.comment_id = comment_id;
    }

    public Integer getComment_like_number() {
        return comment_like_number;
    }

    public void setComment_like_number(Integer comment_like_number) {
        this.comment_like_number = comment_like_number;
    }

    public String getComment_content() {
        return comment_content;
    }

    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public Timestamp getComment_time() {
        return comment_time;
    }

    public void setComment_time(Timestamp comment_time) {
        this.comment_time = comment_time;
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

    public Integer getSub_comment_number() {
        return sub_comment_number;
    }

    public void setSub_comment_number(Integer sub_comment_number) {
        this.sub_comment_number = sub_comment_number;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public String getParent_comment_id() {
        return parent_comment_id;
    }

    public void setParent_comment_id(String parent_comment_id) {
        this.parent_comment_id = parent_comment_id;
    }
}
