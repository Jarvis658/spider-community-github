package com.example.spidercommunity.funs.user.hot.impl;

import com.example.spidercommunity.funs.user.hot.HotDto;
import com.example.spidercommunity.funs.user.hot.HotService;
import com.example.spidercommunity.funs.user.hot.PostCover;
import com.example.spidercommunity.funs.user.hot.dao.HotDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class HotServiceImpl implements HotService {
    private final int LOAD_POST_NUM = 20;

    @Resource
    private HotDao hotDao;

    @Override
    public List<PostCover> hotRecommend(HotDto dto) {
        List<PostCover> postCover = new ArrayList<>();
        postCover.addAll(hotDao.getPostCoverByScore(LOAD_POST_NUM));

        for (int i = 0; i < postCover.size(); i++){
            postCover.get(i).setLike_status(0);
            postCover.get(i).setUser_avatar(hotDao.getUserAvatar(postCover.get(i)));
            postCover.get(i).setPost_like_number(hotDao.getPostLikeNumber(postCover.get(i)));
        }

        return postCover;
    }
}
