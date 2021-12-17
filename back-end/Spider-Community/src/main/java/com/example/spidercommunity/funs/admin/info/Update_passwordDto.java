package com.example.spidercommunity.funs.admin.info;

public class Update_passwordDto {


    String a_id;


    String oldP;

    public String getA_id() {
        return a_id;
    }

    public void setA_id(String a_id) {
        this.a_id = a_id;
    }

    String newP;
    String newPre;

    public String getOldP() {
        return oldP;
    }

    public void setOldP(String oldP) {
        this.oldP = oldP;
    }

    public String getNewP() {
        return newP;
    }

    public void setNewP(String newP) {
        this.newP = newP;
    }

    public String getNewPre() {
        return newPre;
    }

    public void setNewPre(String newPre) {
        this.newPre = newPre;
    }
}
