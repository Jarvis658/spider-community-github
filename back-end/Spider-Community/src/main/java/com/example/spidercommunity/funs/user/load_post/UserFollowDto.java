package com.example.spidercommunity.funs.user.load_post;

public class UserFollowDto {
    private String myUid;
    private String otherUid;

    public UserFollowDto(){}

    public UserFollowDto(String myUid, String otherUid) {
        this.myUid = myUid;
        this.otherUid = otherUid;
    }

    public String getMyUid() {
        return myUid;
    }

    public void setMyUid(String myUid) {
        this.myUid = myUid;
    }

    public String getOtherUid() {
        return otherUid;
    }

    public void setOtherUid(String otherUid) {
        this.otherUid = otherUid;
    }
}
