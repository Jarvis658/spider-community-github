package com.example.spidercommunity.funs.admin.label.dao;

import com.example.spidercommunity.funs.admin.label.DeleteLabelDto;
import com.example.spidercommunity.funs.admin.label.DeletePostId;
import com.example.spidercommunity.funs.admin.label.LabelId;
import com.example.spidercommunity.funs.user.load_post.CommentAndUname;
import com.example.spidercommunity.funs.user.search.SearchResult;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;


public interface DeleteLableDao {
    @Select("select count(*) from label_ where label_name=#{name}")
    int checkExist(DeleteLabelDto dto);

    @Select("select label_id from label_ where label_name=#{name}")
    int getId(DeleteLabelDto dto);

    @Select("select post.post_id from post,post_label where post_label.post_id=post.post_id and post_label.label_id=#{id}")
    List<String> getPostId(LabelId labelId);


    @Delete("delete from label_ where label_id=#{id}")
    void deleteLabel(LabelId labelId);

    @Delete("delete from user_label where label_id=#{id}")
    void deleteUserLabel(LabelId labelId);

    @Delete("delete from comment_like where comment_id = #{comment_id}")
    void deleteCommentLike(CommentAndUname each);

    @Delete("delete from comment where post_id = #{pno}")
    void deleteAllComment(DeletePostId id);

    @Delete("delete from post_like where post_id = #{pno}")
    void deleteAllPostLike(DeletePostId id);

    @Delete("delete from post_label where post_id = #{pno}")
    void deleteAllPostLabel(DeletePostId id);

    @Delete("delete from collect where post_id = #{pno}")
    void deleteAllPostCollected(DeletePostId id);

    @Delete("delete from post where post_id = #{pno}")
    void deletePost(DeletePostId id);
    @Select("select comment_id from comment where post_id=#{pno}")
    List<CommentAndUname> getCommentList(DeletePostId id);


    //search
    @Select("select  label_name from label_ where label_name like #{msg} ")
    List<String> search(@Param("msg")String msg) ;


}
