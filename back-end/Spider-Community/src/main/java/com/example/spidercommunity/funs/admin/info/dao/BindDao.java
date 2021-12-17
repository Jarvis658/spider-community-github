package com.example.spidercommunity.funs.admin.info.dao;

import com.example.spidercommunity.funs.admin.info.BindDto;
import com.example.spidercommunity.funs.admin.info.UnBindDto;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface BindDao {
    @Select("select count(admin_id) from admin where user_id= #{u_id} " )
    int BindCheck1(BindDto dto);

    @Select("select count(user_id) from user where user_id = #{u_id} and user_password = #{u_pwd} " )
    int BindCheck2(BindDto dto);

    @Select("select count(*) from admin where admin_id = #{a_id} and user_id is not null" )
    int BindCheck3(BindDto dto);


    @Update("update admin set user_id=#{u_id} where admin_id= #{a_id}")
    void Bind(BindDto dto);


    @Update("update admin set user_id= null where admin_id= #{a_id}")
    void UnBind(UnBindDto dto);

}
