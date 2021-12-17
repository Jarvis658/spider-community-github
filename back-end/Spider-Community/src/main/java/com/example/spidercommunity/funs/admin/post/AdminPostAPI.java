package com.example.spidercommunity.funs.admin.post;


import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.common.Utils;
import com.example.spidercommunity.funs.user.load_post.PostAndUname;
import com.example.spidercommunity.funs.user.post.PostLastDto;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/admin/post")
public class AdminPostAPI {
    //帖子内容没有图片且没有封面图片 res中的code
    public static final  int PIC_NONE_CODE = 100;
    //帖子内容没有图片且没有封面图片 res中的message
    public static final  String PIC_NONE_MESSAGE = "来张图片做封面吧~";

    @Resource
    private AdminPostService adminPostService;

    @PostMapping("/publish")
    public Result post(@RequestBody AdminPostDto adminpostDto) {
        //postDto包括发贴用户id，帖子标题，帖子内容
        String post_id = UUID.randomUUID().toString();

        try {
            if(adminpostDto.getPost_title()=="" || adminpostDto.getPost_content()==null  || adminpostDto.getPost_content()=="<p><br></p>")
                throw new NullPointerException();
        } catch (NullPointerException e) {
            return Result.fail(Result.ERR_CODE_BUSINESS,"任意一项不得为空！");
        }

        System.out.println("post_id为"+post_id);
        System.out.println("postdto为"+adminpostDto.getUser_id()+adminpostDto.getPost_title()+adminpostDto.getPost_content());

        List<String> pics = new ArrayList<>();
        pics = Utils.getMatchString(adminpostDto.getPost_content());//得到帖子内容中的图片url数组
        System.out.println(pics);

        if (adminpostDto.getCover_url() == "") {
            if (pics.size() == 0) {
                //既没帖子图片又没封面图片
                return Result.fail(PIC_NONE_CODE, PIC_NONE_MESSAGE);
                //这里返回code设为100，供前端判断是否需要单独上传封面
            }
        }


            //最终的发帖dto
            AdminPostLastDto adminPostLastDto = new AdminPostLastDto();
            adminPostLastDto.setPost_id(post_id);
            adminPostLastDto.setPost_content(adminpostDto.getPost_content());
            adminPostLastDto.setPost_title(adminpostDto.getPost_title());
            adminPostLastDto.setUser_id(adminpostDto.getUser_id());

            if(adminpostDto.getCover_url() == "") {
                //若没有封面图片,则选第一张图片做封面（封面图片和帖子图片都没有的已经被排除了）
                adminPostLastDto.setCoverUrl(pics.get(0));//用第一张图片作封面
            }
            else{
                //若上传了封面图片
                adminPostLastDto.setCoverUrl(adminpostDto.getCover_url());
            }
            System.out.println(adminPostLastDto.getCoverUrl());
            adminPostService.postPost(adminPostLastDto);

            return Result.success(post_id);
    }
}
