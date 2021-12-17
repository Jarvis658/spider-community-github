package com.example.spidercommunity.common.dao;

import org.apache.ibatis.annotations.Select;
import com.example.spidercommunity.common.User;


public interface CommonDao {
    @Select("select user_id, user_name, user_avatar, user_password from user where user_id = #{userId}")
    User findUserById(String userId);
}
