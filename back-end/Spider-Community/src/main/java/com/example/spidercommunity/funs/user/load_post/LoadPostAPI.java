package com.example.spidercommunity.funs.user.load_post;

import com.example.spidercommunity.common.Result;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.*;

@RestController
@RequestMapping("/user/load_post")
public class LoadPostAPI {

    @Resource
    private LoadPostService loadPostService;

    @RequestMapping("/loadPost")
    public Result getPost(@RequestBody LoadPostDto dto){
        PostAndUname postAndUname;
        int author_role = loadPostService.checkAuthorRole(dto);
        if(author_role == 0)
            return Result.success(loadPostService.getUserPost(dto));
        else
            return Result.success(loadPostService.getAdminPost(dto));
    }

    @PostMapping("/loadComment")
    public Result commentListOne(@RequestBody LoadPostDto dto){
        List<ArrayList> commentList  = loadPostService.getCommentList(dto);
        return Result.success(commentList);
    }

    @PostMapping("/loadCommentById")
    public Result loadCommentById(@RequestBody LoadPostDto dto){
        CommentAndUname comment  = loadPostService.getCommentById(dto);
        return Result.success(comment);
    }

    @PostMapping("/getUserIdByPostId")
    public Result getUserIdByPostId(String post_id){
        System.out.println(post_id);
        String user_id  = loadPostService.getUserIdByPostId(post_id);
        return Result.success(user_id);
    }
}
