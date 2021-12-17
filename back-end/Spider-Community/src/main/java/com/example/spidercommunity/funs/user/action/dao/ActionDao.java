package com.example.spidercommunity.funs.user.action.dao;

import com.example.spidercommunity.funs.user.action.ActionDto;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface ActionDao {

    @Insert("insert into action_record values (#{post_id}, #{user_id}, 0, current_timestamp, 1)")
    void addViewRecord(ActionDto dto);

    @Select("select count(*) from action_record where user_id = #{user_id} and post_id = #{post_id} and action_id = 0")
    int checkViewRecord(ActionDto dto);

    @Update("update action_record set count = count+1, time = current_timestamp where user_id = #{user_id} and post_id = #{post_id} and action_id = 0")
    void refreshViewRecord(ActionDto dto);
}
