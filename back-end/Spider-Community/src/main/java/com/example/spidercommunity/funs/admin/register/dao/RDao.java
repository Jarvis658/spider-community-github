package com.example.spidercommunity.funs.admin.register.dao;

import com.example.spidercommunity.funs.admin.register.RDto;
import org.apache.ibatis.annotations.Select;

public interface RDao {
    @Select("select count(*) from worker where worker_id = #{w_id} and worker_name = #{w_name}")
    int checkOne(RDto dto);

    @Select("select count(*) from admin where admin_id = #{a_id} ")
    int checkTwo(RDto dto);


    @Select("select count(*) from admin where worker_id = #{w_id} ")
    int checkThree(RDto dto);

    @Select("insert into admin (admin_id, admin_name, admin_password, worker_id, role_id ,user_id) VALUES (#{a_id} , #{name}, #{a_pwd}, #{w_id}, 2 , NULL)")
    void R(RDto dto);

}
