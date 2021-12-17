package com.example.spidercommunity.funs.admin.load_post.dao;

import com.example.spidercommunity.funs.admin.load_post.AdminLoadPostDto;
import com.example.spidercommunity.funs.admin.load_post.PostAndUname;
import com.example.spidercommunity.funs.user.load_post.UserFollowDto;
import org.apache.ibatis.annotations.Select;

public interface AdminLoadPostDao {
    @Select("select post_id,post.user_id,post_time,post_title,post_content,post_like_number,collect_number,comment_number,admin_name,admin_avatar from post,admin where post_id like #{pno}  and post.user_id=admin.admin_id")
    PostAndUname findPost(AdminLoadPostDto loadPostDto);

    @Select("select count(user_id) from post_like where user_id=#{uid} and post_id=#{pno}")
    int checkPostLike(AdminLoadPostDto loadPostDto);

    @Select("select count(user_id) from collect where user_id=#{uid} and post_id=#{pno}")
    int checkCollect(AdminLoadPostDto loadPostDto);

    @Select("select count(follower_id) from follow where follower_id=#{myUid} and followed_id=#{otherUid}")
    int checkFollow(UserFollowDto userFollowDto);

}
