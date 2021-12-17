package com.example.spidercommunity.funs.user.post;

import com.example.spidercommunity.common.ImageUploadController;
import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.common.Utils;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.naming.spi.DirStateFactory;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;


@RestController
@RequestMapping("/user/post")
public class PostAPI {

    //帖子内容没有图片且没有封面图片 res中的code
    public static final  int PIC_NONE_CODE = 100;
    //帖子内容没有图片且没有封面图片 res中的message
    public static final  String PIC_NONE_MESSAGE = "来张图片做封面吧~";

    @Resource
    private PostService postService;

    @PostMapping("/publish")
    public Result post(@RequestBody PostDto postDto) {
        //postDto包括发贴用户id，帖子标题，帖子内容
        String post_id = UUID.randomUUID().toString();

        try {
            if(postDto.getPost_title()=="" || postDto.getPost_content()==null  || postDto.getPost_content()=="<p><br></p>")
                throw new NullPointerException();
        } catch (NullPointerException e) {
            return Result.fail(Result.ERR_CODE_BUSINESS,"任意一项不得为空！");
        }

        System.out.println("post_id为"+post_id);
        System.out.println("postdto为"+postDto.getUser_id()+postDto.getPost_title()+postDto.getPost_content());

        List<String> pics = new ArrayList<>();
        pics = Utils.getMatchString(postDto.getPost_content());//得到帖子内容中的图片url数组
        System.out.println(pics);

        if (postDto.getCover_url() == "") {
            if (pics.size() == 0) {
                //既没帖子图片又没封面图片
                return Result.fail(PIC_NONE_CODE, PIC_NONE_MESSAGE);
                //这里返回code设为100，供前端判断是否需要单独上传封面
            }
        }

        if(pics.size() > 9)//上传图片不能超过9张
            return Result.fail(Result.ERR_CODE_BUSINESS,"上传图片太多辣！！");
        else {
        //最终的发帖dto
        PostLastDto postLastDto = new PostLastDto();
        postLastDto.setPost_id(post_id);
        postLastDto.setPost_content(postDto.getPost_content());
        postLastDto.setPost_title(postDto.getPost_title());
        postLastDto.setUser_id(postDto.getUser_id());

        if(postDto.getCover_url() == "") {
            //若没有封面图片,则选第一张图片做封面（封面图片和帖子图片都没有的已经被排除了）
            postLastDto.setCoverUrl(pics.get(0));//用第一张图片作封面
        }
        else{
            //若上传了封面图片
            postLastDto.setCoverUrl(postDto.getCover_url());
        }
            System.out.println(postLastDto.getCoverUrl());
        postService.postPost(postLastDto);

        return Result.success(post_id);
        }
    }

    @RequestMapping("/searchPost")
    public Result searchPost(String post_id) {
            PostLastDto postLastDto = postService.searchPost(post_id);
            System.out.println(postLastDto.getPost_content()+"jjj");
            return Result.success(postLastDto);
    }

    @RequestMapping("/searchLabel")
    public Result searchLabel(String post_id) {
        List<String> labelArray= postService.searchLabelInPostLabel(post_id);
        return Result.success(labelArray);
    }

    @RequestMapping("/label")
    public Result postLabel(@RequestBody PostLabelDto postLabelDto) {
        //dto里包含了post_id,user_id和labelArray
        postService.postLabel(postLabelDto);
        return Result.success();
    }

    @RequestMapping("/updatePost")
    public Result updatePost(@RequestBody PostLastDto postLastDto) {
        try {
            if(postLastDto.getPost_title()=="" || postLastDto.getPost_content()==null  || postLastDto.getPost_content()=="<p><br></p>")
                throw new NullPointerException();
        } catch (NullPointerException e) {
            return Result.fail(Result.ERR_CODE_BUSINESS,"任意一项不得为空！");
        }

        System.out.println("postLastDto为"+postLastDto.getUser_id()+postLastDto.getPost_title()+postLastDto.getPost_content());

        List<String> pics = new ArrayList<>();
        pics = Utils.getMatchString(postLastDto.getPost_content());//得到帖子内容中的图片url数组
        System.out.println(pics);

        if (postLastDto.getCoverUrl() == null) {
            if (pics.size() == 0) {
                //既没帖子图片又没封面图片
                return Result.fail(PIC_NONE_CODE, PIC_NONE_MESSAGE);
                //这里返回code设为100，供前端判断是否需要单独上传封面
            }
        }

        if(pics.size() > 9)//上传图片不能超过9张
            return Result.fail(Result.ERR_CODE_BUSINESS,"上传图片太多辣！！");
        else {

            if(postLastDto.getCoverUrl() == null) {
                //若没有封面图片,则选第一张图片做封面（封面图片和帖子图片都没有的已经被排除了）
                postLastDto.setCoverUrl(pics.get(0));//用第一张图片作封面
            }

            System.out.println(postLastDto.getCoverUrl());

            //最终的二次发帖dto
            RewriteDto rewriteDto = new RewriteDto();
            rewriteDto.setPost_id(postLastDto.getPost_id());
            rewriteDto.setPost_content(postLastDto.getPost_content());
            rewriteDto.setPost_title(postLastDto.getPost_title());
            rewriteDto.setUser_id(postLastDto.getUser_id());
            rewriteDto.setCoverUrl(postLastDto.getCoverUrl());
            rewriteDto.setAudit_status(0);
            postService.updatePost(rewriteDto);
        return Result.success();
    }
    }

    @RequestMapping("/updateLabel")
    public Result updateLabel(@RequestBody PostLabelDto postLabelDto) {
        //dto里包含了post_id和labelArray
        postService.deleteLabel(postLabelDto.getPost_id());
        postService.postLabel(postLabelDto);
        return Result.success();
    }

    @RequestMapping("/delete")
    public Result deletePost(@RequestBody PostLastDto postDto) {
        System.out.println(postDto.getPost_id());
        postService.deletePost(postDto);
        return Result.success();
    }

    @RequestMapping("/report")
    public Result reportPost(@RequestBody PostLastDto postLastDto) {
        postService.reportPost(postLastDto);
        return Result.success();
    }

    @RequestMapping("/view_history")
    public Result viewHistory(@RequestBody PostDto postDto) {
        List<PostLastDto> postList = postService.viewHistory(postDto);
        return Result.success(postList);
    }


}
