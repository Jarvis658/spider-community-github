package com.example.spidercommunity.funs.user.login.dao;

import com.example.spidercommunity.funs.user.login.LoginDto;
import org.apache.ibatis.annotations.Select;

public interface LoginDao {

    @Select("select count(user_id) from user where user_id = #{u_id} and user_password = #{u_pwd}")
    int findCountByUserIdAndPassword(LoginDto dto);

    @Select("select count(user_id) from user where user_name = #{u_id} and user_password = #{u_pwd}")
    int findCountByUserNameAndPassword(LoginDto dto);

    @Select("select user_id from user where user_name = #{u_id} and user_password = #{u_pwd}")
    String getUserIdByUidAndUpwd(LoginDto dto);

    @Select("select count(user_id) from user where user_name = #{u_id}")
    int checkLoginWithName(LoginDto dto);

    @Select("select count(user_id) from user where user_phone = #{u_id}")
    int checkPhoneExist(LoginDto dto);

    @Select("select user_id from user where user_phone = #{u_id}")
    int getUserIdByPhone(LoginDto dto);
}
