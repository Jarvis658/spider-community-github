package com.example.spidercommunity.funs.admin.info;

import com.example.spidercommunity.common.ImageUploadController;
import com.example.spidercommunity.common.Result;
import com.example.spidercommunity.funs.user.info.User;
import com.example.spidercommunity.funs.user.info.UserInfo;
import com.example.spidercommunity.funs.user.info.UserInfoDto;
import com.example.spidercommunity.funs.user.info.UserInfoService;
import com.example.spidercommunity.funs.user.load_post.LoadPostService;
import com.example.spidercommunity.funs.user.load_post.PostAndUname;
//import com.example.spidercommunity.funs.user.login.User;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/info")
public class AdminInfoAPI {

    @Resource
    private AdminInfoService adminInfoService;

    @Resource
    private UserInfoService userInfoService;

    @RequestMapping("/view_current")
    public Result getCurrentInfo(@RequestBody AdminInfoDto adminInfoDto){
        System.out.println(adminInfoDto.getUid());
        Admin admin = adminInfoService.getCurrentInfo(adminInfoDto);
        return Result.success(admin);
    }

    @RequestMapping("/view_c")
    public Result getCInfo(@RequestBody AdminInfoDto adminInfoDto){
        boolean bind = adminInfoService.checkBind(adminInfoDto);
        if(bind) {
            String uid = adminInfoService.getUserId(adminInfoDto);
            User userInfo = userInfoService.getUserInfo(new UserInfoDto(uid));
            return Result.success("Bind", userInfo);
        }
        else {
            return Result.success("No Bind");
        }


    }
    //更改管理员头像，后端将图片上传至七牛云
    @RequestMapping(value = "/update_avatar")
    public Result UpdateAdminAvatar(@RequestParam("avatar") MultipartFile adminAvatar, @RequestParam("admin_id") String admin_id) throws Exception{
        ImageUploadController imageUploadController = new ImageUploadController();
        String token = imageUploadController.getToken().getMessage();
        String fileKey = "admin_avatar"+System.currentTimeMillis();
        String avatarUrl = imageUploadController.uploadQiNiu(adminAvatar, token, fileKey).getMessage();
        try{
            adminInfoService.updateAvatar(avatarUrl,admin_id);
        }catch (Exception e ){
            return Result.fail(Result.ERR_CODE_BUSINESS,"修改头像失败");
        }
        return Result.success("修改头像成功");
    }
    //更改c端用户头像，后端将图片上传至七牛云
    @RequestMapping(value = "/update_avatar_c")
    public Result UpdateAvatar_C(@RequestParam("avatar") MultipartFile adminAvatar, @RequestParam("user_id") String user_id) throws Exception{
        ImageUploadController imageUploadController = new ImageUploadController();
        String token = imageUploadController.getToken().getMessage();
        String fileKey = "admin_avatar_c"+System.currentTimeMillis();
        String avatarUrl = imageUploadController.uploadQiNiu(adminAvatar, token, fileKey).getMessage();
        try{
            System.out.println(avatarUrl);
            adminInfoService.updateAvatar_C(avatarUrl,user_id);
        }catch (Exception e ){
            return Result.fail(Result.ERR_CODE_BUSINESS,"修改头像失败");
        }
        return Result.success("修改头像成功");
    }
}
