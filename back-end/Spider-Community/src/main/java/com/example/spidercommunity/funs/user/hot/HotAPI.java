package com.example.spidercommunity.funs.user.hot;


import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.common.TokenUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/user/tab/hot")
public class HotAPI {

    @Resource
    private HotService hotService;

    @RequestMapping("")
    public Result hotPost(@RequestBody HotDto dto){

            List<PostCover> hotList = hotService.hotRecommend(dto);
            return Result.success(hotList);

    }


}
