package com.example.spidercommunity.funs.user.recommend;

import java.util.ArrayList;
import java.util.List;

public class Utils {

    public static List<PostCover> deleteRepeatPost(List<PostCover> postCover){
        for (int i = 0; i < postCover.size(); i++){
            for (int j = i+1; j < postCover.size(); j++){
                if (postCover.get(i).getPost_id().equals(postCover.get(j).getPost_id()))
                    postCover.remove(j);
            }
        }
        return postCover;
    }

    public static List<LabelAndScore> deleteRepeatLabel(List<LabelAndScore> newLabels){
        for (int i = 0; i < newLabels.size(); i++){
            for (int j = i+1; j < newLabels.size(); j++){
                if (newLabels.get(i).getLabel_id() == newLabels.get(j).getLabel_id())
                    newLabels.remove(j);
            }
        }
        return newLabels;
    }

    public static List<LabelAndNum> calculateLoadPostNumbers(List<LabelAndScore> labelAndScore, int LOAD_POST_NUM, String myself) {
        List<LabelAndNum> labelAndNum = new ArrayList<>();
        double sumScore = 0;
        for (int i = 0; i < labelAndScore.size(); i++)
            sumScore += labelAndScore.get(i).getScore();
        for (int i = 0; i < labelAndScore.size(); i++){
            int label_id = labelAndScore.get(i).getLabel_id();
            double score = labelAndScore.get(i).getScore();
            int load_number = (int) (score / sumScore * LOAD_POST_NUM);
            LabelAndNum calculated = new LabelAndNum(label_id, load_number, myself);
            labelAndNum.add(calculated);
        }

        return labelAndNum;
    }


    public static double pearson(List<Double> vector1, List<Double> vector2) {
        //检查向量维度是否相同
        if (vector1.size() != vector2.size())
            return -100;

        double up = 0, down1 = 0, down2 = 0, aver1 = 0, aver2 = 0;
        int size = vector1.size();

        for (int i = 0; i < size; i++){
            aver1 += vector1.get(i);
            aver2 += vector2.get(i);
        }
        aver1 /= size;
        aver2 /= size;

        for (int i = 0; i < size; i++){
            up += (vector1.get(i) - aver1) * (vector2.get(i) - aver2);
            down1 += Math.pow((vector1.get(i) - aver1), 2);
            down2 += Math.pow((vector2.get(i) - aver2), 2);
        }

        double sim = up / (Math.sqrt(down1 * down2));

        return sim;
    }


    public static List<UserSimilarity> sortSimilarity(List<UserSimilarity> list, int num) {
        for (int i = 0; i < num; i++)
            for (int j = list.size() - 1; j > i; j--){
                if (list.get(j).getCalculate() > list.get(j-1).getCalculate())
                    swap(list.get(j), list.get(j-1));
            }
        return list;
    }

    private static void swap(UserSimilarity a, UserSimilarity b) {
        UserSimilarity temp = new UserSimilarity(a);
        a.setUser_id(b.getUser_id());
        a.setCalculate(b.getCalculate());
        b.setUser_id(temp.getUser_id());
        b.setCalculate(temp.getCalculate());
    }


}
