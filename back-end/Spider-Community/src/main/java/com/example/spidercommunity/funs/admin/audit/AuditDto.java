package com.example.spidercommunity.funs.admin.audit;

//存储数据

public class AuditDto {
    //    private String u_id;
//
//    public String getU_id() {
//        return u_id;
//    }
//
//    public void setU_id(String u_id) {
//        this.u_id = u_id;
//    }
    private int audit_status;
    private String post_id;
    private String user_id;

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
//    private String post_title;

    public int getAudit_status() {
        return audit_status;
    }

    public void setAudit_status(int audit_status) {
        this.audit_status = audit_status;
    }

    public String getPost_id() {
        return post_id;
    }

    public void setPost_id(String post_id) {
        this.post_id = post_id;
    }

//    public String getPost_content(){return post_title;}

//    public void setPost_content(String post_title){this.post_title=post_title;}
}