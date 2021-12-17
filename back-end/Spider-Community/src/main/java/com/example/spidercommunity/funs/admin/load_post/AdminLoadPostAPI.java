package com.example.spidercommunity.funs.admin.load_post;

import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/load_post")
public class AdminLoadPostAPI {
    @Resource
    private AdminLoadPostService adminLoadPostService;

    @RequestMapping("/loadPost")
    public Result getPost(@RequestBody AdminLoadPostDto dto){
        System.out.println(dto.getPno()+dto.getUid());
        PostAndUname postAndUname = adminLoadPostService.getPost(dto);
        return Result.success(postAndUname);
    }

}
