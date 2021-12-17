package com.example.spidercommunity.funs.user.recommend;

import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController //放在容器中，为spring管理的对象
@RequestMapping("/user/tab/recommend")
public class RecommendAPI {

    @Resource
    private RecommendService recommendService;

    @RequestMapping("/test")
    public String test(){
        return "recommend API 测试正常！哈哈哈";
    }

    //想哥看这里！！
    @RequestMapping("/testdao")
    public Result testdao(@RequestBody RecommendDto dto){
        List<LabelAndScore> labelAndScores = recommendService.testRecommend(dto);
        return Result.success(labelAndScores);
    }

    @RequestMapping("")
    public Result recommendPost(@RequestBody RecommendDto dto){
//        String postUserId = TokenUtils.fromTokenGetUserId(token);
       // String userId = dto.getU_id();
       // if (postUserId.equals(userId)){
            //用来接收数据库返回数据的list中的类，其中的变量名要与数据库数据名完全一致
            List<PostCover> recommendList = recommendService.personalizedRecommend(dto);
            return Result.success(recommendList);
//        }
//        else { return Result.fail(500,"加载出错！"); }
    }

}
