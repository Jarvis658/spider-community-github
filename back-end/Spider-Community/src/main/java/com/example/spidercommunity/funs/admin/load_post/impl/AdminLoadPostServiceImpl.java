package com.example.spidercommunity.funs.admin.load_post.impl;

import com.example.spidercommunity.funs.admin.load_post.AdminLoadPostDto;
import com.example.spidercommunity.funs.admin.load_post.AdminLoadPostService;
import com.example.spidercommunity.funs.admin.load_post.PostAndUname;
import com.example.spidercommunity.funs.admin.load_post.dao.AdminLoadPostDao;
import com.example.spidercommunity.funs.user.load_post.UserFollowDto;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class AdminLoadPostServiceImpl implements AdminLoadPostService {
    @Resource
    private AdminLoadPostDao adminLoadPostDao;

    @Override
    public PostAndUname getPost(AdminLoadPostDto adminLoadPostDto) {
        PostAndUname postAndUname = adminLoadPostDao.findPost(adminLoadPostDto);
        System.out.println(postAndUname.getPost_content());
        int like_status = adminLoadPostDao.checkPostLike(adminLoadPostDto);
        int collect_status = adminLoadPostDao.checkCollect(adminLoadPostDto);
        int follow_status = adminLoadPostDao.checkFollow(new UserFollowDto(adminLoadPostDto.getUid(), postAndUname.getUser_id()));

        if(collect_status > 0)
            postAndUname.setCollect_status(1);
        else
            postAndUname.setCollect_status(0);

        postAndUname.setLike_status(like_status);
        postAndUname.setFollow_status(follow_status);
        return postAndUname;
    }
}
