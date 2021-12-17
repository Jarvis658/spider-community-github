package com.example.spidercommunity.funs.admin.post.impl;

import com.example.spidercommunity.funs.admin.post.DelRecommendService;
import com.example.spidercommunity.funs.admin.post.AdminRecommendDto;
import com.example.spidercommunity.funs.admin.post.dao.DelRecommendDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
@Service
@Transactional
public class DelRecommendServiceImpl implements DelRecommendService {
    @Resource
    private DelRecommendDao delRecommendDao;

    @Override
    public void DelRecommend(AdminRecommendDto dto) {
        delRecommendDao.delRec(dto);
    }
}
