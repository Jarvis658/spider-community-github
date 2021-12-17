package com.example.spidercommunity.funs.user.hot.dao;

import com.example.spidercommunity.funs.user.hot.PostCover;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface HotDao {

    @Select("select post_title, cover_image, user_name, post_like_number, post.user_id, post_id, timestampdiff(day, post_time, current_timestamp) as diff, " +
            "(recommended_score * (exp(-0.1373 * (timestampdiff(day, post_time, current_timestamp) + 3.72) )+0.4)) as calculate, " +
            "post_time from post, (select user_id, user_name from user) as name " +
            "where name.user_id = post.user_id order by calculate desc limit #{LOAD_POST_NUM}")
    List<PostCover> getPostCoverByScore(int load_post_num);

    @Select("select count(user_id) from post_like where post_id = #{post_id}")
    int getPostLikeNumber(PostCover postCover);

    @Select("select user_avatar from user where user_id = #{user_id}")
    String getUserAvatar(PostCover postCover);
}
