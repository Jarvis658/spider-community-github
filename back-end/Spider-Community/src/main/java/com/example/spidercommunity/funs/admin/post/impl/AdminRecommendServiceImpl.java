package com.example.spidercommunity.funs.admin.post.impl;

import com.example.spidercommunity.funs.admin.post.AdminRecommendDto;
import com.example.spidercommunity.funs.admin.post.AdminRecommendService;
import com.example.spidercommunity.funs.admin.post.dao.AdminRecommendDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class AdminRecommendServiceImpl implements AdminRecommendService {
    @Resource
    private AdminRecommendDao adminRecommendDao;

    @Override
    public void Recommend(AdminRecommendDto dto) {
        adminRecommendDao.addRec(dto);

    }

    @Override
    public String check(AdminRecommendDto dto) {
        int cnt= adminRecommendDao.check(dto);
        if (cnt>0)return"已推荐";
        else return "未推荐";
    }
}
