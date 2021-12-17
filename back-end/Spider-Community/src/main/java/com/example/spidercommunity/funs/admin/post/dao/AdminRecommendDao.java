package com.example.spidercommunity.funs.admin.post.dao;

import com.example.spidercommunity.funs.admin.post.AdminRecommendDto;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface AdminRecommendDao {
    @Update("update post set recommended_status = 1  where post_id=#{p_id} ")
    int addRec(AdminRecommendDto dto) ;

    @Select("Select count(*) from post  where recommended_status = 1  and post_id=#{p_id} ")
    int check(AdminRecommendDto dto) ;
}
