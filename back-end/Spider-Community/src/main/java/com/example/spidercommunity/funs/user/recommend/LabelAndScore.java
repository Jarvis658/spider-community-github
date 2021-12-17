package com.example.spidercommunity.funs.user.recommend;

public class LabelAndScore {
    //接收数据库返回数据的类 变量名要与数据库中字段一致
    private int label_id;
    private double score;

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
