package com.example.spidercommunity.funs.user.interaction;


import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.funs.user.info.User;
import com.example.spidercommunity.funs.user.load_post.LoadPostDto;
import com.example.spidercommunity.funs.user.load_post.UserFollowDto;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/user/interaction")
public class InteractionAPI {

    @Resource
    private InteractionService interactionService;

    @RequestMapping("/like_post")
    public Result likePost(@RequestBody LoadPostDto dto) {
        interactionService.likePost(dto);
        return Result.success();
    }

    @RequestMapping("/loadCollectGroups")
    public Result loadCollectGroups(@RequestBody LoadPostDto dto) {
        List<CollectGroup> collectGroupsList = interactionService.loadCollectFolders(dto);
        return Result.success(collectGroupsList);
    }

    @RequestMapping("/collect")
    public Result collectPost(@RequestBody LoadCollectionGroupDto loadCollectionGroupDto) {
        interactionService.collectPost(loadCollectionGroupDto);
        return Result.success();
    }

    @RequestMapping("/view_like")
    public Result getPostLikeDto(@RequestBody PostLikeDto  postlikedto){
        List<PostLike> postlike = interactionService.getPostLike(postlikedto);
        return Result.success(postlike);
    }

    @RequestMapping("/view_comment")
    public Result getComment(@RequestBody CommentDto  commentdto){
        List<Commment> commment = interactionService.getComment(commentdto);
        return Result.success(commment);
    }

    @RequestMapping("/comment")
    public Result comment(@RequestBody CommentDto commentDto) {
        String uuid = UUID.randomUUID().toString().toUpperCase();
        Date date = new Date();
        commentDto.setComment_id(uuid);
        commentDto.setComment_time(date);
        interactionService.comment(commentDto);
        return Result.success();
    }

    @RequestMapping("/delete_comment")
    public Result deleteComment(@RequestBody CommentDto commentDto) {
        interactionService.deleteComment(commentDto);
        return Result.success();
    }

    @RequestMapping("/like_comment")
    public Result likeComment(@RequestBody LoadPostDto loadPostDto) {
        interactionService.likeComment(loadPostDto);
        return Result.success();
    }

    @RequestMapping("/attention")
    public Result attention(@RequestBody UserFollowDto userFollowDto) {
        interactionService.attention(userFollowDto);
        return Result.success();
    }

    @RequestMapping("/followers")
    public Result getFans(@RequestBody CommentDto  commentdto){
        List<User> user = interactionService.getViewfollower(commentdto);
        return Result.success(user);
    }
    //查看用户关注
    @RequestMapping("/view_attention")
    public Result getViewattention(@RequestBody CommentDto  commentdto){
        List<User> user = interactionService.getViewattention(commentdto);
        return Result.success(user);
    }



}
