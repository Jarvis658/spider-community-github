package com.example.spidercommunity.funs.admin.info.dao;

import com.example.spidercommunity.funs.admin.info.UpdateInfoDto;
import org.apache.ibatis.annotations.Update;

public interface UpdateInfoDao {

    @Update("update admin set admin_name = #{name} , admin_sex = #{sex} ,admin_birthday = #{birthday} ,admin_avatar = #{avatar} where admin_id=#{id}")
    int UpdateAdminInfo(UpdateInfoDto dto);

//    @Update("update admin set admin_sex = #{sex} where admin_id=#{id}")
//    int UpdateAdminSex(UpdateInfoDto dto);
//
//    @Update("update admin set admin_birthday = #{birthday} where admin_id=#{id}")
//    int UpdateAdminBirth(UpdateInfoDto dto);
//
//    @Update("update admin set admin_avatar = #{avatar} where admin_id=#{id}")
//    int UpdateAdminAvatar(UpdateInfoDto dto);
}
