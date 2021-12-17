package com.example.spidercommunity.funs.admin.login.dao;

import com.example.spidercommunity.funs.admin.login.A_id;
import com.example.spidercommunity.funs.admin.login.AdminLoginDto;
import org.apache.ibatis.annotations.Select;
import com.example.spidercommunity.funs.user.login.LoginDto;

public interface AdminLoginDao {

    @Select("select count(admin_id) from admin where admin_id = #{a_id} and admin_password = #{a_pwd}")
    int findCountByUserIdAndPassword(AdminLoginDto dto);

    @Select("select count(admin_id) from admin where admin_name = #{a_id} and admin_password = #{a_pwd}")
    int findCountByUserNameAndPassword(AdminLoginDto dto);

    @Select("select admin_id from admin where admin_name = #{a_id} and admin_password = #{a_pwd}")
    String getAdminIdByAnameAndApwd(AdminLoginDto dto);

    @Select("select count(admin_id) from admin where admin_name = #{a_id}")
    int checkLoginWithName(AdminLoginDto dto);

    @Select("select admin_name from admin where admin_name = #{a_id}")
    String getAdminName(A_id a_id);
}
