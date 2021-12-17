package com.example.spidercommunity.funs.user.interaction.dao;

import com.example.spidercommunity.funs.user.info.User;
import com.example.spidercommunity.funs.user.interaction.*;
//import com.example.spidercommunity.funs.user.interaction.ColletGroup;
import com.example.spidercommunity.funs.user.load_post.LoadPostDto;
import com.example.spidercommunity.funs.user.load_post.UserFollowDto;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface InteractionDao {

    @Delete("delete from post_like where user_id = #{uid} and post_id = #{pno}")
    void deletePostLike(LoadPostDto loadPostDto);

    @Update("update post SET post_like_number = post_like_number-1 WHERE post_id = #{pno}")
    void decreasePostLikeNumber(LoadPostDto loadPostDto);

    @Insert("insert into post_like(user_id,post_id,like_time) values(#{uid},#{pno},#{postLikeTime})")
    void insertPostLike(PostLikeDto postLikeDto);

    @Update("update post SET post_like_number = post_like_number+1 WHERE post_id = #{pno}")
    void increasePostLikeNumber(LoadPostDto loadPostDto);

    @Select("select collect_group_id,collect_group_name,post_number from collect_group where user_id=#{uid}")
    List<CollectGroup> loadCollectFolders(LoadPostDto dto);

    @Select("select count(post_id) from collect where post_id=#{pno} and collect_group_id=#{collectGroupId}")
    int checkCollectionStatus(LoadCollectionGroupDto dto);

    @Delete("delete from collect where collect_group_id = #{collectGroupId} and post_id = #{pno}")
    void deletePostCollect(LoadCollectionGroupDto LoadCollectionGroupDto);

    @Update("update post SET collect_number = collect_number-1 WHERE post_id = #{pno}")
    void decreasePostCollectNumber(LoadCollectionGroupDto LoadCollectionGroupDto);

    @Update("update collect_group SET post_number = post_number-1 WHERE collect_group_id = #{collectGroupId}")
    void decreaseCollectContentNumber(LoadCollectionGroupDto loadCollectionGroupDto);

    @Insert("insert into collect(user_id,post_id,collect_time,collect_group_id) values(#{uid},#{pno},#{postCollectTime},#{collectGroupId})")
    void insertPostCollect(LoadCollectionGroupDto loadCollectionGroupDto);

    @Update("update post SET collect_number = collect_number+1 WHERE post_id = #{pno}")
    void increasePostCollectNumber(LoadCollectionGroupDto loadCollectionGroupDto);

    @Update("update collect_group SET post_number = post_number+1 WHERE collect_group_id = #{collectGroupId}")
    void increaseCollectContentNumber(LoadCollectionGroupDto loadCollectionGroupDto);

    @Delete("delete from comment_like where user_id = #{uid} and comment_id = #{pno}")
    void deleteCommentLike(LoadPostDto loadPostDto);

    @Update("update comment SET comment_like_number = comment_like_number-1 WHERE comment_id = #{pno}")
    void decreaseCommentLikeNumber(LoadPostDto loadPostDto);

    @Insert("insert into comment_like(user_id,comment_id) values(#{uid},#{pno})")
    void insertCommentLike(LoadPostDto loadPostDto);

    @Update("update comment SET comment_like_number = comment_like_number+1 WHERE comment_id = #{pno}")
    void increaseCommentLikeNumber(LoadPostDto loadPostDto);

    @Insert("insert into comment(comment_id,post_id,user_id,parent_comment_id,comment_content,comment_time) values(#{comment_id},#{post_id},#{user_id},#{parent_comment_id},#{comment_content},#{comment_time})")
    void comment(CommentDto commentDto);

    @Update("update post SET comment_number = comment_number+1 WHERE post_id = #{post_id}")
    void increaseCommentNumber(CommentDto commentDto);

    @Select("select comment_id,post_id,user_id,parent_comment_id from comment where parent_comment_id=#{comment_id}")
    List<CommentDto> findSubComment(CommentDto commentDto);

    @Delete("delete from comment_like where comment_id = #{comment_id}")
    void deleteThisCommentLike(CommentDto commentDto);

    @Delete("delete from comment where comment_id = #{comment_id}")
    void deleteThisComment(CommentDto commentDto);

    @Update("update post SET comment_number = comment_number-1 WHERE post_id = #{post_id}")
    void decreasePostCommentNumber(CommentDto commentDto);

    @Delete("delete from follow where follower_id = #{myUid} and followed_id = #{otherUid}")
    void deleteFollow(UserFollowDto userFollowDto);

    @Update("update user SET fans_number = fans_number-1 WHERE user_id = #{otherUid}")
    void decreaseFansNumber(UserFollowDto userFollowDto);

    @Update("update user SET attention_number = attention_number-1 WHERE user_id = #{myUid}")
    void decreaseAttentionNumber(UserFollowDto userFollowDto);

    @Insert("insert into follow(follower_id,followed_id) values(#{myUid},#{otherUid})")
    void insertFollow(UserFollowDto userFollowDto);

    @Update("update user SET fans_number = fans_number+1 WHERE user_id = #{otherUid}")
    void increaseFansNumber(UserFollowDto userFollowDto);

    @Update("update user SET attention_number = attention_number+1 WHERE user_id = #{myUid}")
    void increaseAttentionNumber(UserFollowDto userFollowDto);


    @Select("SELECT post_like.like_time,post.post_title FROM post, post_like where post_like.user_id=#{user_id} and post.post_id=post_like.post_id order by like_time DESC")
    List<PostLike> getPostLike(PostLikeDto postlikedto);

    @Select("SELECT comment.comment_content,comment.comment_time,comment.post_id,post.post_title FROM post,comment where comment.user_id=#{user_id} and post.post_id=comment.post_id order by comment_time DESC")
    List<Commment> getComment(CommentDto commentdto);

    @Select("select user.* from user,follow where user.user_id=follow.followed_id and follow.follower_id= #{user_id} ")
    List<User> getViewattention(CommentDto commentdto);

    @Select("select user.* from user,follow where user.user_id=follow.follower_id and follow.followed_id= #{user_id} ")
    List<User> getViewfollower(CommentDto commentdto);
}
