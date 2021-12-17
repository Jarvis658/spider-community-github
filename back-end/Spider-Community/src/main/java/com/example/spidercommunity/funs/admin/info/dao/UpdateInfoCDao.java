package com.example.spidercommunity.funs.admin.info.dao;

import com.example.spidercommunity.funs.admin.info.UpdateInfoCDto;
import com.example.spidercommunity.funs.admin.info.UpdateInfoDto;
import org.apache.ibatis.annotations.Update;

public interface UpdateInfoCDao {


    @Update("update user set user_name = #{name} , user_sex = #{sex} ,user_birthday = #{birthday} ,user_signature=#{signature} ,user_school=#{school},user_avatar = #{avatar} where user_id=#{id}")
    void UpdateCInfo(UpdateInfoCDto dto);
}
