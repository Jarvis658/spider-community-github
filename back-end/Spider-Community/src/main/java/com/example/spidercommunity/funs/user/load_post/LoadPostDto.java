package com.example.spidercommunity.funs.user.load_post;

public class LoadPostDto {
    private String pno;
    private String uid;

    public LoadPostDto() {}

    public LoadPostDto(String pno) {
        this.pno = pno;
    }

    public LoadPostDto(String pno, String uid) {
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
