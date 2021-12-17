package com.example.spidercommunity.funs.user.recommend;

public class LabelAndNum {
    private int label_id;
    private int number;
    private String myself;

    public LabelAndNum(int label_id, int number, String myself){
        this.label_id = label_id;
        this.number = number;
        this.myself = myself;
    }

    public int getLabel_id() {
        return label_id;
    }

    public void setLabel_id(int label_id) {
        this.label_id = label_id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getMyself() {
        return myself;
    }

    public void setMyself(String myself) {
        this.myself = myself;
    }
}
