package com.example.spidercommunity.funs.user.post.dao;

import com.example.spidercommunity.funs.user.load_post.CommentAndUname;
import com.example.spidercommunity.funs.user.post.*;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface PostPostDao {
    @Insert("insert into post (post_id, post_title, post_content, user_id, cover_image, author_role) values (#{post_id} , #{post_title}, #{post_content}, #{user_id}, #{coverUrl}, 0)")
    void insertPost(PostLastDto postLastDto);

    @Insert("insert into post_label (post_id,label_id) values (#{post_id} , #{label_id})")
    void insertLabel(String post_id, int label_id);

    @Insert("insert into label_ (label_id, label_name) values (0,#{label_name})")
    void newLabel(String label_name);

    @Select("select count(label_id) from label_ where label_name= #{label_i}")
    int searchLabel(String label_i);

    @Select("select label_id from label_ where label_name=#{label_i}")
    int selectLabelID(String label_i);

    @Select("select post_id,user_id,post_title,post_content from post where post_id = #{post_id}")
    PostLastDto searchPost(String post_id);

    @Update("update post set post_title=#{post_title} ,post_content=#{post_content},cover_image=#{coverUrl},audit_status=#{audit_status} where post_id = #{post_id}")
    void updatePost(RewriteDto rewriteDto);

    @Select("select label_name from post_label,label_ where label_.label_id = post_label.label_id and post_id=#{post_id}")
    List<String> searchLabelInPostLabel(@Param("post_id")String post_id);

    @Select("select comment_id from comment where post_id=#{post_id}")
    List<CommentAndUname> getCommentList(PostLastDto postDto);

    @Delete("delete from comment_like where comment_id = #{comment_id}")
    void deleteCommentLike(CommentAndUname each);

    @Delete("delete from comment where post_id = #{post_id}")
    void deleteAllComment(PostLastDto postDto);

    @Delete("delete from post_like where post_id = #{post_id}")
    void deleteAllPostLike(PostLastDto postDto);

    @Delete("delete from post_label where post_id = #{post_id}")
    void deleteAllPostLabel(PostLastDto postDto);

    @Delete("delete from collect where post_id = #{post_id}")
    void deleteAllPostCollected(PostLastDto postDto);
    
    @Delete("delete from post where post_id = #{post_id}")
    void deletePost(PostLastDto postDto);

    @Delete("delete from post_label where post_id = #{post_id}")
    void deleteLabel(String post_id);

    @Update("update post SET report_number = report_number + 1 where post_id = #{post_id}")
    void increasePostReportNumber(PostLastDto postDto);

    @Select("select * from post where user_id = #{user_id}")
    List<PostLastDto> viewHistory(com.example.spidercommunity.funs.user.post.PostDto postDto);

    @Select("select count(label_id) from user_label where label_id= #{label_id} and user_id= #{user_id}")
    int searchLabelInUserLabel(String user_id, int label_id);

    @Insert("insert into user_label (user_id,label_id,score) values (#{user_id} , #{label_id}, #{score})")
    void insertUserLabel(PostLabelLastDto postLastLabelDto);

    @Update("update user_label set score=score+ #{score} where user_id = #{user_id} and label_id = #{label_id}")
    void updateUserLabel(PostLabelLastDto postLastLabelDto);

    @Insert("insert into report(user_id, post_id) values (#{user_id} , #{post_id})")
    void reportPost(PostLastDto postDto);

    @Select("select report_number from post where post_id = #{post_id}")
    int checkReportNumber(PostLastDto postDto);

    @Update("update post set audit_status = 0 where post_id = #{post_id}")
    void solveReport(PostLastDto postDto);
}
