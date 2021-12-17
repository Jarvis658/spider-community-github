package com.example.spidercommunity.funs.user.favorites.dao;

import com.example.spidercommunity.funs.user.favorites.CollectDto;
import com.example.spidercommunity.funs.user.favorites.CollectGroup;
import com.example.spidercommunity.funs.user.favorites.CollectGroupDto;
import com.example.spidercommunity.funs.user.favorites.Post;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface CollectGroupDao {
    @Select("select * from collect_group where user_id = #{user_id}")
    List<CollectGroup> getCollectGroup(CollectGroupDto collectGroupDto);

    @Insert("insert into collect_group(user_id,collect_group_name,display_status) values(#{user_id},#{collect_group_name},#{display_status})")
    void addCollectGroup(CollectGroupDto collectGroupDto);

    @Delete("delete from collect_group where collect_group_id = #{collect_group_id}")
    void deleteCollectGroup(CollectGroupDto collectGroupDto);

    @Update("update collect_group set collect_group_name = #{collect_group_name},display_status = #{display_status} where collect_group_id = #{collect_group_id}")
    void updateCollectGroup(CollectGroupDto collectGroupDto);

    @Select("SELECT post.* FROM post,collect where collect.collect_group_id=#{collect_group_id} and post.post_id=collect.post_id")
    List<Post> getCollectGroupContent(CollectGroupDto collectGroupDto);


    @Delete("delete from collect where collect_group_id = #{collect_group_id} and post_id=#{post_id}")
    void deleteCollectGroupLike(CollectDto collectDto);

    @Delete("delete from collect where collect_group_id = #{collect_group_id}")
    void deleteCollectGroupContent(CollectGroupDto collectGroupDto);

    @Update("update collect_group set post_number = post_number - 1 where collect_group_id =#{collect_group_id}")
    void decreaseCollectPostNumber(CollectDto collectDto);

    @Select("select * from collect_group where user_id = #{user_id} and display_status=1")
    List<CollectGroup> getOtherCollectGroup(CollectGroupDto collectGroupDto);
}
