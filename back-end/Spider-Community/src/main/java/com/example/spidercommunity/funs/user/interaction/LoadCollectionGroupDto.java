package com.example.spidercommunity.funs.user.interaction;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class LoadCollectionGroupDto {
    private String pno;
    private String uid;
    private String collectGroupId;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date postCollectTime;

    public LoadCollectionGroupDto(){}

    public LoadCollectionGroupDto(String pno, String uid, String collectGroupId) {
        this.pno = pno;
        this.uid = uid;
        this.collectGroupId = collectGroupId;
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

    public String getCollectGroupId() {
        return collectGroupId;
    }

    public void setCollectGroupId(String collectGroupId) {
        this.collectGroupId = collectGroupId;
    }

    public Date getPostCollectTime() {
        return postCollectTime;
    }

    public void setPostCollectTime(Date postCollectTime) {
        this.postCollectTime = postCollectTime;
    }
}
