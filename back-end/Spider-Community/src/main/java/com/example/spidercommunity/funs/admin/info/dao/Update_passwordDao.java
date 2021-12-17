package com.example.spidercommunity.funs.admin.info.dao;

import com.example.spidercommunity.funs.admin.info.Update_passwordDto;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;


public interface Update_passwordDao {

    @Select("select count(admin_id) from admin where admin_id = #{a_id} and admin_password = #{oldP}")
    int findCountByAdminIDAndPassword(Update_passwordDto dto);


    @Update("update admin SET admin_password=#{newP} where admin_id = #{a_id}")
    void updateAdminPwd(Update_passwordDto dto) ;

}
