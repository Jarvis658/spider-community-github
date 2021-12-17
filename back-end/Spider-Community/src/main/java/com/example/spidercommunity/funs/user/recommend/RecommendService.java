package com.example.spidercommunity.funs.user.recommend;

import java.util.List;

public interface RecommendService {
    List<PostCover> personalizedRecommend(RecommendDto dto);

    List<LabelAndScore> testRecommend(RecommendDto dto);
}
