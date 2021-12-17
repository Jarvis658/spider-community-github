package com.example.spidercommunity.funs.admin.load_post;

public class AdminLoadPostDto {

    private String pno;
    private String uid;

    public AdminLoadPostDto() {}

    public AdminLoadPostDto(String pno) {
        this.pno = pno;
    }

    public AdminLoadPostDto(String pno, String uid) {
        this.pno = pno;
        this.uid = uid;
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
}