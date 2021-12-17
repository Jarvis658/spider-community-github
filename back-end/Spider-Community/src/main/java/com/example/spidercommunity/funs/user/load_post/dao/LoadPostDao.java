package com.example.spidercommunity.funs.user.load_post.dao;

import org.apache.ibatis.annotations.Select;
import com.example.spidercommunity.funs.user.load_post.*;

import java.util.List;

public interface LoadPostDao {

    @Select("select post_id,post.user_id,post_time,post_title,post_content,post_like_number,collect_number,comment_number,user_name,user_avatar,author_role from post,user where post_id like #{pno} and post.user_id=user.user_id")
    PostAndUname findUserPost(LoadPostDto loadPostDto);

    @Select("select post_id,post.user_id,post_time,post_title,post_content,admin_name as user_name,admin_avatar as user_avatar,author_role from post,admin where post_id like #{pno} and post.user_id=admin.admin_id")
    PostAndUname findAdminPost(LoadPostDto dto);

    @Select("select count(user_id) from post_like where user_id=#{uid} and post_id=#{pno}")
    int checkPostLike(LoadPostDto loadPostDto);

    @Select("select count(user_id) from collect where user_id=#{uid} and post_id=#{pno}")
    int checkCollect(LoadPostDto loadPostDto);

    @Select("select count(follower_id) from follow where follower_id=#{myUid} and followed_id=#{otherUid}")
    int checkFollow(UserFollowDto userFollowDto);

    @Select("select count(user_id) from report where user_id=#{uid} and post_id=#{pno}")
    int checkReport(LoadPostDto loadPostDto);

    @Select("select * from comment,user where parent_comment_id=#{pno} and comment.user_id=user.user_id ORDER BY comment_like_number DESC,comment_time DESC")
    List<CommentAndUname> getCommentList(LoadPostDto loadPostDto);

    @Select("select count(user_id) from comment_like where user_id=#{uid} and comment_id=#{pno}")
    int checkCommentLike(LoadPostDto loadPostDto);

    @Select("select * from comment,user where comment_id=#{pno} and comment.user_id=user.user_id")
    CommentAndUname getCommentById(LoadPostDto loadPostDto);

    @Select("select author_role from post where post_id = #{pno} ")
    int checkAuthorRole(LoadPostDto dto);

    @Select("select user_id from post where post_id = #{post_id}")
    String getUserIdByPostId(String post_id);
}
