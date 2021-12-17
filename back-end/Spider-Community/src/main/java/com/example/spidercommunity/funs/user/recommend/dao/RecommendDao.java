package com.example.spidercommunity.funs.user.recommend.dao;

import com.example.spidercommunity.funs.user.recommend.*;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RecommendDao {

    @Select("select (score * (exp(-0.1373 * (timestampdiff(day, last_update_time, current_timestamp)+3.72))+0.4))" +
            " as score, label_id from user_label where user_id = #{u_id} limit 8")
    List<LabelAndScore> getUserLabelAndScore(RecommendDto dto);

    @Select("select * from (select post.post_id, post_title, cover_image, user_id, post_like_number, post_time, " +
            "(recommended_score * (exp(-0.1373 * (timestampdiff(day, post_time, current_timestamp) + 3.72) )+0.4)) as score " +
            "from post, post_label where post.post_id = post_label.post_id and post.post_id not in (select post_id from action_record " +
            "where user_id = #{myself}) and label_id = #{label_id}) as sortPost " +
            "inner join (select user_id, user_name, user_avatar from user) as selectedUser on selectedUser.user_id = sortPost.user_id " +
            "order by score desc limit #{number}")
    List<PostCover> getPostCoverByLabel(LabelAndNum dto);


    @Select("select follower_id, followed_id from follow where follower_id = #{u_id} order by recent_update_time desc limit #{num}")
    List<Followed> getMyFollow(@Param("u_id") String u_id, @Param("num") int num);


    @Select("select * from (select post_id, post_title, cover_image, user_id, post_like_number, post_time, " +
            "(recommended_score * (exp(-0.1373 * (timestampdiff(day, post_time, current_timestamp) + 3.72) )+0.4)) as score " +
            "from post where user_id = #{followed_id} and post_id not in (select post_id from action_record " +
            "where user_id = #{follower_id}) order by post_time desc limit 1) as selectedPost inner join " +
            "(select user_id, user_name, user_avatar from user) as selectedUser on selectedUser.user_id = selectedPost.user_id")
    List<PostCover> getPostCoverByFollow(Followed dto);

    @Select("select user_id, label_id, (score * (exp(-0.1373 * (timestampdiff(day, last_update_time, current_timestamp) + 3.72) )+0.4)) as score " +
            "from user_label where user_id = #{u_id} order by label_id")
    List<UserLabelScore> getUserLabelScore(RecommendDto dto);

    @Select("select user_id from user_label where label_id = #{label_id} and user_id != #{user_id}")
    List<String> findIntersectUserByLabel(UserLabelScore userLabelScore);

    @Select("select (score * (exp(-0.1373 * (timestampdiff(day, last_update_time, current_timestamp)+3.72))+0.4)) as score " +
            "from user_label where user_id = #{user_id} and label_id = #{label_id}")
    List<Double> getScoreByLabelAndUser(UserLabelScore currAndLabel);

    @Select("select label_id, score from user_label where user_id = #{similar} and label_id not in (select label_id from " +
            "user_label where user_id = #{my}) order by score desc limit 2")
    List<LabelAndScore> getNewLabels(@Param("similar") String similarUser, @Param("my") String myUser);


    @Select("select post_id from post_like where user_id = #{user} and post_id not in " +
            "(select post_id from action_record where user_id = #{myself})")
    List<PostId> getNewPostIdByLikes(String myself, String user);


    @Select("select * from (select post_id, post_title, cover_image, user_id, post_like_number, post_time, " +
            "(recommended_score * (exp(-0.1373 * (timestampdiff(day, post_time, current_timestamp) + 3.72) )+0.4)) as score " +
            "from post where post_id = #{post_id}) as Post inner join " +
            "(select user_id, user_name, user_avatar from user) as User on User.user_id = Post.user_id")
    List<PostCover> getPostCoverByPostId(PostId postId);

    @Select("select count(user_id) from post_like where post_id = #{post_id}")
    int getPostLikeNumber(PostCover postCover);
}
