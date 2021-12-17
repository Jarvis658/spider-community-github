package com.example.spidercommunity.funs.admin.post.impl;

import com.example.spidercommunity.funs.admin.post.*;
import com.example.spidercommunity.funs.admin.post.dao.AdminPostDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class AdminPostServiceImpl implements AdminPostService {
    @Resource
    private AdminPostDao adminPostDao;

    @Override
    public void postPost(AdminPostLastDto adminPostLastDto) {
        adminPostDao.insertPost(adminPostLastDto);
    }


}
