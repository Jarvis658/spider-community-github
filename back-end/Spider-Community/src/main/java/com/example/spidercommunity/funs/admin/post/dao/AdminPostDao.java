package com.example.spidercommunity.funs.admin.post.dao;

import com.example.spidercommunity.funs.admin.post.AdminPostLastDto;
import org.apache.ibatis.annotations.Insert;


public interface AdminPostDao {
    @Insert("insert into post (post_id, post_title, post_content, user_id, cover_image,audit_status,author_role) values (#{post_id} , #{post_title}, #{post_content}, #{user_id}, #{coverUrl},1,1)")
    void insertPost(AdminPostLastDto adminPostLastDto);
}
