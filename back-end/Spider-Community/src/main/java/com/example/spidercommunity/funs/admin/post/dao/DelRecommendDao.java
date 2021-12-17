package com.example.spidercommunity.funs.admin.post.dao;

import com.example.spidercommunity.funs.admin.post.AdminRecommendDto;
import org.apache.ibatis.annotations.Update;

public interface DelRecommendDao {

    @Update("update post set recommended_status = 0  where post_id=#{p_id} ")
    int delRec(AdminRecommendDto dto) ;
}
