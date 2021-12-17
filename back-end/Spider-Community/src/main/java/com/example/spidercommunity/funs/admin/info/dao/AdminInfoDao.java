package com.example.spidercommunity.funs.admin.info.dao;

import com.example.spidercommunity.funs.admin.info.Admin;
import com.example.spidercommunity.funs.admin.info.AdminInfoDto;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface AdminInfoDao {
    @Select("select * from admin where admin_id = #{uid}")
    Admin getCurrentInfo(AdminInfoDto adminInfoDto);

    @Select("select count(admin_id) from admin where admin_id = #{uid} and user_id is not null")
    int checkBind(AdminInfoDto adminInfoDto);

    @Select("select user_id as uid from admin where admin_id = #{uid}")
    AdminInfoDto getUserId(AdminInfoDto adminInfoDto);

    @Update("update admin set admin_avatar = #{avatarUrl} where admin_id=#{admin_id}")
    void updateAvatar(String avatarUrl, String admin_id);

    @Update("update user set user_avatar = #{avatarUrl} where user_id=#{user_id}")
    void updateAvatar_C(String avatarUrl, String user_id);
}
