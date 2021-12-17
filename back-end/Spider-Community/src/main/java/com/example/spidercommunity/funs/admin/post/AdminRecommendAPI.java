package com.example.spidercommunity.funs.admin.post;



import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/post/recommend")
public class AdminRecommendAPI {

    @Resource
    private AdminRecommendService adminRecommendService;

    @RequestMapping("")
    public Result Recommend(@RequestBody AdminRecommendDto dto){
        adminRecommendService.Recommend(dto);
        return Result.success("推荐成功");
    }

    @RequestMapping("/check")
    public Result RecommendCheck(@RequestBody AdminRecommendDto dto){
        String res= adminRecommendService.check(dto);
        return Result.success("推荐情况",res);
    }

}
