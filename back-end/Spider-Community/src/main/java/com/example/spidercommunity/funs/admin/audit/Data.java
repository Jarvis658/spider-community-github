package com.example.spidercommunity.funs.admin.audit;

public class Data {
    private String post_id;
    private int audit_status;
    private String post_title;
    private String post_content;
    private String cover_image;
    private String user_id;
    public String getPost_content() {
        return post_content;
    }

    public void setPost_content(String post_content) {
        this.post_content = post_content;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

    public int getAudit_status() {
        return audit_status;
    }

    public void setAudit_status(int audit_status) {
        this.audit_status = audit_status;
    }

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

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
}
