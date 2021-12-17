package com.example.spidercommunity.funs.user.recommend;

public class UserLabelScore {
    private String user_id;
    private int label_id;
    private double score;

    public UserLabelScore(){};
    public UserLabelScore(String user, int label){
        user_id = user;
        label_id = label;
        score = -1;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public int getLabel_id() {
        return label_id;
    }

    public void setLabel_id(int label_id) {
        this.label_id = label_id;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
}
