package com.example.spidercommunity.funs.user.interaction;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.security.Timestamp;
import java.util.Date;

public class PostLikeDto {
    private String pno;
    private String uid;

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    private String user_id;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date postLikeTime;
    public PostLikeDto(){}

    public PostLikeDto(String pno, String uid, Date date) {
        this.pno = pno;
        this.uid = uid;
        this.postLikeTime = date;

    }

    public String getPno() {
        return pno;
    }

    public void setPno(String pno) {
        this.pno = pno;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public Date getPostLikeTime() {
        return postLikeTime;
    }

    public void setPostLikeTime(Date postLikeTime) {
        this.postLikeTime = postLikeTime;
    }
}
