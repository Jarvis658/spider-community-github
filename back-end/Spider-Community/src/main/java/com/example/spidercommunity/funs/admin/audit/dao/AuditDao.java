package com.example.spidercommunity.funs.admin.audit.dao;

import com.example.spidercommunity.funs.admin.audit.Data;
import com.example.spidercommunity.funs.admin.audit.AuditDto;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
;
//9
public interface AuditDao {

//    @Select("select post_id from post")
//    int findCountByUserIdAndPassword(AuditDto dto);
//
//    @Select("select audit_status from post")
//    int findCountByUserNameAndPassword(AuditDto dto)
//    @Select("select post_id, post_title from post where user_id = #{u_id}")
//    List<Data> findMyPost(AuditDto dto);

    @Select("select post_id,audit_status,post_title,post_content,cover_image,user_id from post")
    List<Data> loadAllPost(AuditDto dto);

    @Select("select post_content from post where post_id=#{post_id}")
    List<Data> loadContent(AuditDto dto);
//    Collection<? extends Data> loadAllPost(AuditDto dto);

    @Update("update post set audit_status=#{audit_status} where post_id=#{post_id}")// ? insert into database;
    void changeStatus(AuditDto dto);

}
