package com.example.spidercommunity.funs.user.recommend;

public class UserSimilarity {
    private String user_id;
    private double similarity;

    public UserSimilarity(String user_id, double similarity){
        this.user_id = user_id;
        this.similarity = similarity;
    }

    public UserSimilarity(UserSimilarity curr){
        this.user_id = curr.getUser_id();
        this.similarity = curr.getCalculate();
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public double getCalculate() {
        return similarity;
    }

    public void setCalculate(double calculate) {
        this.similarity = calculate;
    }
}
