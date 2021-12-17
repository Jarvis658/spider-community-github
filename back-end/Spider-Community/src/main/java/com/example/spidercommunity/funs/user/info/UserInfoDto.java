package com.example.spidercommunity.funs.user.info;

public class UserInfoDto {
    private String uid;

    public UserInfoDto(){}

    public UserInfoDto(String uid) {
        this.uid = uid;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
}
