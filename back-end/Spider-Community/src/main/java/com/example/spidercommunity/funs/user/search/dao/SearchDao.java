package com.example.spidercommunity.funs.user.search.dao;

import com.example.spidercommunity.funs.user.recommend.PostCover;
import com.example.spidercommunity.funs.user.search.SearchResult;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Collection;
import java.util.List;

public interface SearchDao {
    @Select("select * from post,user where post_content like #{msg} AND post.user_id=user.user_id")
    List<SearchResult> findPost1(@Param("msg")String msg) ;

    @Select("select * from post,user where post_title like #{msg} AND post.user_id=user.user_id")
    List<SearchResult> findPost2(@Param("msg")String msg) ;

    @Select("select * from post,user where user.user_name like #{msg} AND post.user_id=user.user_id")
    List<SearchResult> findPost3(@Param("msg")String msg) ;

    @Select("select DISTINCT * from post,user,label_,post_label where post.post_id=post_label.post_id AND post_label.label_id=label_.label_id  AND post.user_id=user.user_id AND label_.label_name like #{msg} group by user.user_id ")
    List<SearchResult> findPost4(@Param("msg")String msg) ;

    @Select("select count(user_id) from post_like where post_id = #{post_id}")
    int getPostLikeNumber(SearchResult searchResult);

    @Select("select * from post,admin where admin.admin_name like #{msg} AND post.user_id=admin.admin_id")
    List<SearchResult> findPost5(@Param("msg")String msg) ;
}
