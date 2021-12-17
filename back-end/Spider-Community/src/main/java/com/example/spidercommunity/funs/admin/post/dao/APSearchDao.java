package com.example.spidercommunity.funs.admin.post.dao;

import com.example.spidercommunity.funs.admin.post.APSearchResult;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface APSearchDao {
    @Select("select * from post,user where post_content like #{msg} AND post.user_id=user.user_id")
    List<APSearchResult> APfindPost1(@Param("msg")String msg) ;

    @Select("select * from post,user where post_title like #{msg} AND post.user_id=user.user_id")
    List<APSearchResult> APfindPost2(@Param("msg")String msg) ;

    @Select("select * from post,user where user.user_id=#{msg} AND post.user_id=user.user_id ")
    List<APSearchResult> APfindPost3(@Param("msg")int msg) ;

    @Select("select * from post,user where post_id= #{msg} AND post.user_id=user.user_id")
    List<APSearchResult> APfindPost4(@Param("msg")String msg) ;
}
