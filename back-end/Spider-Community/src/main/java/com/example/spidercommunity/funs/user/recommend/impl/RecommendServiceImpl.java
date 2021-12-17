package com.example.spidercommunity.funs.user.recommend.impl;

import com.example.spidercommunity.funs.user.recommend.*;
import com.example.spidercommunity.funs.user.recommend.dao.RecommendDao;
import com.example.spidercommunity.funs.user.recommend.Utils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@Service
@Transactional
public class RecommendServiceImpl implements RecommendService {
    //设定一次预加载的帖子数量
    private final int LOAD_POST_NUM = 20;
    private final int LOAD_FOLLOW_POST_NUM = 8;
    private final int SIMILAR_USER_NUM = 2;     //找到前x个相似用户
    private final int NEW_LABELS = 2;           //拓展标签中挑选x个，推送y篇该标签下最火的未浏览过的文章
    private final int NEW_LABEL_POST_NUM = 1;
    private final int NEW_USERS_LIKE = 2;       //相似用户中挑选x个，推送y篇他们的的点赞文章
    private final int NEW_LIKE_POST_NUM = 2;

    @Resource
    private RecommendDao recommendDao;

    @Override
    public List<PostCover> personalizedRecommend(RecommendDto dto) {
        List<PostCover> postCover = new ArrayList<>();
        String myself = dto.getU_id();
        //===================================================================================================


        //加载用户标签下最火的文章
        //待优化：标签数量太多的时候，可能算出来的数量小于1
        //解决方式：只加载前几个标签？
        //目前限制加载前8的标签
        List<LabelAndScore> labelAndScore= recommendDao.getUserLabelAndScore(dto);
        List<LabelAndNum> labelAndNum = Utils.calculateLoadPostNumbers(labelAndScore, LOAD_POST_NUM, myself);
        for (int i = 0; i < labelAndScore.size(); i++){
            postCover.addAll(recommendDao.getPostCoverByLabel(labelAndNum.get(i)));
        }


        //==================================================================================================


        //加载已关注用户的最新的没看过的文章
        List<Followed> followed = recommendDao.getMyFollow(myself, LOAD_FOLLOW_POST_NUM * 2);
        for (int i = 0; i < LOAD_FOLLOW_POST_NUM; i++){

            if (followed.size() > LOAD_FOLLOW_POST_NUM){
                //从前16个关注用户中随机加载8个用户中未看过的最新的文章
                int index = (int) (Math.random() * followed.size() * 2);
                postCover.addAll(recommendDao.getPostCoverByFollow(followed.get(index)));
            }
            else if(followed.size()==0)break;
            else {
                postCover.addAll(recommendDao.getPostCoverByFollow(followed.get(i)));
                if (i == followed.size() - 1) break;
            }
        }


        //==================================================================================================


        //用户_标签的协同过滤
        //========================找到有标签交集的用户========================
        //后期优化：根据用户分数最高的x个标签进行筛选
        List<UserLabelScore> userLabel = recommendDao.getUserLabelScore(dto);

        List<String> intersect = recommendDao.findIntersectUserByLabel(userLabel.get(0));
        //构造用户的标签分数向量
        List<Double> vector1 = new ArrayList<>();
        vector1.add(userLabel.get(0).getScore());
        for (int i = 1; i < userLabel.size(); i++){
            vector1.add(userLabel.get(i).getScore());
            List<String> newIntersect = recommendDao.findIntersectUserByLabel(userLabel.get(i));
            intersect.retainAll(newIntersect);
        }

        //=========================计算相似度=============================
        //提取交集用户的标签分数向量，利用Pearson公式计算相似度
        List<UserSimilarity> similarUsers = new ArrayList<>();
        for (int i = 0; i < intersect.size(); i++){
            String currUser = intersect.get(i);
            List<Double> vector2 = new ArrayList<>();
            //构造当前相似用户的标签分数向量，对应label顺序已隐含式相同
            for (int j = 0; j < userLabel.size(); j++){
                UserLabelScore currAndLabel = new UserLabelScore(currUser, userLabel.get(j).getLabel_id());
                vector2.addAll(recommendDao.getScoreByLabelAndUser(currAndLabel));
            }
            //计算匹配用户的相关系数并排序
            similarUsers.add(new UserSimilarity(currUser, Utils.pearson(vector1, vector2)));
        }
        //至此已分离出偏好最相似用户，并且已按相似度评分排好序
        similarUsers = Utils.sortSimilarity(similarUsers, SIMILAR_USER_NUM);


        //===================================================================================================


        //推荐新标签（拓展标签）下最火文章
        List<LabelAndScore> newLabels = new ArrayList<>();
        String myUser = userLabel.get(0).getUser_id();
        for (int i = 0; i < similarUsers.size(); i++){
            newLabels.addAll(recommendDao.getNewLabels(similarUsers.get(i).getUser_id(), myUser));
        }
        newLabels = Utils.deleteRepeatLabel(newLabels);
        //限制扩展标签数
        for (int i = 0; i < NEW_LABELS; i++){
            if (i == newLabels.size()) break;
            //可优化选项：选择加载新标签文章的个数（目前为1）
            int label = newLabels.get(i).getLabel_id();
            LabelAndNum look = new LabelAndNum(label, NEW_LABEL_POST_NUM, myself);
            postCover.addAll(recommendDao.getPostCoverByLabel(new LabelAndNum(label, NEW_LABEL_POST_NUM, myself)));
        }

        //====================================================================================================


        //相似用户点赞文章
        for (int i = 0; i < NEW_USERS_LIKE; i++){
            if (i == similarUsers.size()) break;
            String user = similarUsers.get(i).getUser_id();
            List<PostId> postIds = recommendDao.getNewPostIdByLikes(myself, user);
            for (int j = 0; j < NEW_LIKE_POST_NUM; j++){
                if (postIds.size() == 0 || j == postIds.size()) break;
                int index = (int) (Math.random() * postIds.size());
                postCover.addAll(recommendDao.getPostCoverByPostId(postIds.get(index)));
            }
        }


        //====================================================================================================



        //因为一个帖子往往有多个标签，所以筛选后，需删除重复的帖子
        //有时候会导致，本来预加载10个帖子，因帖子有多个标签且被重复加载，导致最终预加载数量不够10个
        postCover = Utils.deleteRepeatPost(postCover);

        for (int i = 0; i < postCover.size(); i++){
            postCover.get(i).setPost_like_number(recommendDao.getPostLikeNumber(postCover.get(i)));
            postCover.get(i).setLike_status(0);
        }

        return postCover;
    }

    @Override
    public List<LabelAndScore> testRecommend(RecommendDto dto) {
        List<LabelAndScore> labelAndScore= recommendDao.getUserLabelAndScore(dto);
        return labelAndScore;
    }
}
