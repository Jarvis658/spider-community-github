package com.example.spidercommunity.funs.user.register.dao;

import com.example.spidercommunity.funs.user.register.RegisterDto;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;


public interface RegisterDao {

    @Select("select count(user_name) from user where user_name = #{u_name}")
    int checkRepeatUserName(RegisterDto dto);

    @Insert("insert into user(user_id, user_name, user_password, role_id, register_time, user_phone) " +
            "values(#{u_id}, #{u_name}, #{u_pwd}, 1, current_timestamp, #{u_phone})")
    void CreateUser(RegisterDto dto);

    @Select("select count(user_id) from user where user_id = #{u_id} and user_name = #{u_name} and user_password = #{u_pwd}")
    int checkRegister(RegisterDto dto);

    @Select("select count(user_id) from user where user_id = #{u_id}")
    int checkExistUserId(RegisterDto dto);

    @Select("select max(user_id) from user")
    int getNewUid(RegisterDto dto);

    @Select("select count(user_phone) from user where user_phone = #{u_phone}")
    int checkRepeatUserPhone(RegisterDto dto);
}
