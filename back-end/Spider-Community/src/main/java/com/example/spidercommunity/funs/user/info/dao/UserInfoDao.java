package com.example.spidercommunity.funs.user.info.dao;

import com.example.spidercommunity.funs.user.info.User;
import com.example.spidercommunity.funs.user.info.UserInfoDto;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface UserInfoDao {
    @Select("select * from user where user_id = #{uid}")
    User getUserInfo(UserInfoDto userInfoDto);

    @Update("update user set user_password = #{user_password} where user_id = #{user_id}")
    void updateUserInfoPwd(User user);

    @Update("update user set user_sex = #{user_sex},user_name=#{user_name},user_avatar = #{user_avatar},user_signature = #{user_signature},school_name=#{school_name},user_birthday=#{user_birthday} where user_id = #{user_id}")
    void updateUserInfo(User user);
}
