package com.example.spidercommunity.funs.admin.users.dao;

import com.example.spidercommunity.funs.admin.users.AUSearchResult;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AUSearchDao {
    @Select("select * from user where user_id = #{msg} ")
    List<AUSearchResult> AUfindPost1(@Param("msg")int msg) ;

    @Select("select * from user where user_name like #{msg} ORDER BY register_time DESC")
    List<AUSearchResult> AUfindPost2(@Param("msg")String msg) ;

    @Select("select * from user where user_name like #{msg} ORDER BY recent_login DESC")
    List<AUSearchResult> AUfindPost3(@Param("msg")String msg) ;


}
