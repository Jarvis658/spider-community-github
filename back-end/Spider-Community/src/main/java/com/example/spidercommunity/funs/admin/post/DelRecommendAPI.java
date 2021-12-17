package com.example.spidercommunity.funs.admin.post;



import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/post/delete_recommend")
public class DelRecommendAPI {

    @Resource
    private DelRecommendService delRecommendService;

    @RequestMapping("")
    public Result DelRecommend(@RequestBody AdminRecommendDto dto){
        delRecommendService.DelRecommend(dto);
        return Result.success("删除推荐成功");
    }

}
